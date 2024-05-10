Return-Path: <linux-kernel+bounces-175469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3058C201E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF61F1F22411
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DB615F3F4;
	Fri, 10 May 2024 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etDYEzpJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08BC1A2C0F
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715331393; cv=none; b=svpGOsqr5GMClKhgQ68VMVSIZ1KuEyJoR3ehy5sP+ZT4Li2ONaDBSZLYZvkAprwc+UGqB7B4YO7nyZlVfVcijTI8bWEVJUobPrWfffPlusw/eim19cAWiygVyxaN0mbkZ3Xg57O04D800cNL1XG7/T+/SgriRbbyWgKFZvrnoMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715331393; c=relaxed/simple;
	bh=izZhTAs24+RZPRwsuYPyAh/Q5x2bwkt7e9K6VD1gvss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4bAXJY6iK6K7qdv9DrJfu2ucby3u01U0thRLaVsjOSpJG486zJbnfyo7Ti6NDSno5FpHs0JtbdlQmDq1C7OlToLOypxQ/oLYT08AGiVQuHehiV/94diKNJQiLtHrGdCS9UTqcUIm+YU+WLsPdQ5KeHk5Dl8FolYp5KDk8sDTaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=etDYEzpJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715331390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+/1HtW1diUXyOoT1UpVHQ9HQK9UPwOclrTertb9H4QQ=;
	b=etDYEzpJJBXovzbI5u2lmz++5/kTpi822PhqAjU2tFBDEVes4tZ6fgxZpM6EgPkJwOsie4
	WZcrHHyxUm5jodobxOBkqUpAS/RdY28G68VY3EVady9I0tmheKz42YSsHuwF+2leQB7kna
	So2DjTUwB7da78iwA/maNZ4gGFdFR/4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-vgzUQzDKMFWo-_ucL6eIkw-1; Fri, 10 May 2024 04:56:29 -0400
X-MC-Unique: vgzUQzDKMFWo-_ucL6eIkw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78eeb60e1fbso225948085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 01:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715331388; x=1715936188;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/1HtW1diUXyOoT1UpVHQ9HQK9UPwOclrTertb9H4QQ=;
        b=HtwRhJ9pBL5siibAnYjO93VTVEQT7/EW8veDAWy4xwA0QCec7Gdc1IM47hJPR9K2n+
         ScS/HhAA1UiXljvHtqpqDBjWByznZHjxjC+F7IrRxTM7rIScj5vdcymNZrQvqtWivtnb
         wE5X/IEXxYX7ZM1aiiOu8UDrysP/qU9Dvz68Xl6dRYPS7U1EeUxF7qj8BhzTiYTCAnyB
         MushoRV5fkBUmy/KqEAOMxunT8fNt+DlUIZLLLois1DZdewZyEx4VvGGy/n7aC9DS+fl
         9pcV7iMYoJ9BZvwFBJOjAstxb4g57TRK/LoC6HhwQV8dIfMK8Aq7GM8zRLlPxuIWwDJb
         BcPA==
X-Gm-Message-State: AOJu0YzP9II49bxo9iVs4ADBwHqLNVkTnOBDpg71I4jCpu47r3UXgb/Q
	3wUssverBjCEBfG2iT4DxZxho3jm2/gKrnZS+pEVfOTmxspDFR4w6gU2g+vhWbANyOkFD0p/6Ty
	4mS/9jCS9hqzd62nTW0n2XeOLWO7UqOep+AR6LnWDqRRkSaj4IHCJ4FdjbXI5Gg==
X-Received: by 2002:a05:6214:1150:b0:6a0:af07:1141 with SMTP id 6a1803df08f44-6a1683ab841mr13156006d6.65.1715331388472;
        Fri, 10 May 2024 01:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5P++0rvu3ocHs00JXzkLOeTOkX35WNC4wcph6t+zaDEiJDoZ6O0MnzdTrK8D+63uj/2cnZw==
X-Received: by 2002:a05:6214:1150:b0:6a0:af07:1141 with SMTP id 6a1803df08f44-6a1683ab841mr13155956d6.65.1715331388142;
        Fri, 10 May 2024 01:56:28 -0700 (PDT)
Received: from ?IPV6:2001:1620:4baa:0:3ee1:a1ff:fe52:711b? ([2001:1620:4baa:0:3ee1:a1ff:fe52:711b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f18520dsm15512416d6.44.2024.05.10.01.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 01:56:27 -0700 (PDT)
Message-ID: <2b3ea2b9-1959-40ff-b8f9-5ad1569f72be@redhat.com>
Date: Fri, 10 May 2024 10:56:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Fixes tag needs some work in the amdgpu tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240509082313.1249dabf@canb.auug.org.au>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>
Content-Language: en-CA
In-Reply-To: <20240509082313.1249dabf@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-05-09 00:23, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>    27557a840463 ("drm/amdgpu: Fix comparison in amdgpu_res_cpu_visible")
> 
> Fixes tag
> 
>    Fixes: a6ff969fe9 ("drm/amdgpu: fix visible VRAM handling during faults")
> 
> has these problem(s):
> 
>    - SHA1 should be at least 12 digits long
>      This can be fixed for the future by setting core.abbrev to 12 (or
>      more) or (for git v2.11 or later) just making sure it is not set
>      (or set to "auto").

It wouldn't have helped, since I pruned it manually from the full hash 
(from gitk). The intention was pruning to 12 as always, apparently I 
miscounted though. Oops.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer


