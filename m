Return-Path: <linux-kernel+bounces-266817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8102A940813
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0FC11C20CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998A615FCED;
	Tue, 30 Jul 2024 06:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cxQe/C8+"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F38624
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722319574; cv=none; b=joVOMfI85ckU3k7XDF1si7HjrNDtWVbgici7AuOQQiihtRch0cbkqve3cMTuamWoU4BpVsDnRLzP3pdQo1pbRtm0jxS8/FcXUhvZ/2OEZ4DE0OkUXhK6zZa9MNUIiXJryhylcs31WMtEHautQWCE9+ehTOZIb7yxP+49jjONgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722319574; c=relaxed/simple;
	bh=xuekcHc4T9wVcUBrL/CHZr6NJkTHKOHit3ADj+/ZeuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lc1wNaeOkky1cRu5GonfFamBSj6868qc3SJrTORtTRdDz8XThiuNo3A7FA2usvwqymkI5SfQk/1INvMI/UnRdqAxuAeNKq/m8FjUZUaZ88u1Hz7qJgsdRXjk3uLZsl3z1J4Ul71qFA9NpwjIRg4G5W3efTKDuP9TaGmse/kD6b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cxQe/C8+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd69e44596so26226965ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722319572; x=1722924372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghR+ox5/tsfe3PmXNdvY/LSvBA5a53YyAUx9h+7cnSQ=;
        b=cxQe/C8+72Q6GBadCoPRiJXl5iGdRSwR9skMCfed5QXonXCKrWvJVIFiExSXG3T9La
         10FCgNbrAFCLXAQm3DkPemrEh/y2N8zueCdOCp+GP1j3yJcTUI//YHveihY4/EzyzkTQ
         0FCB/PmlEz1Smh9vn5jS0wpACkl8+O09zTCaoRcFu/DfVdR711k71DHJ64ISaVVUukl0
         0jOELJ9SrCNz3MiHhTuyCPhNd05BcqbFY2eHSIcXUq8b3n9WuyUS2wbuq1vRH8WnPfxT
         Dc//V0wpAaRe08PENCmKUbeQqio9LdDoDrxr3Htibi0P1cfvO0UgtEitIkdg7CKuJx5v
         Gr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722319572; x=1722924372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ghR+ox5/tsfe3PmXNdvY/LSvBA5a53YyAUx9h+7cnSQ=;
        b=A7mambmbl7+T/f52Ov/zTx7PVpoa8U+uiPwx92QQrW9AphqLlrVjTIkaDeEO8ho07l
         HPW0nxSWpo3b/TVOqZf8j4klY7OJpAI/A0dCwEdPefdK9bKNCNHHb6sHy2bmuY6Izryt
         xNfrI5U6tqjQ7/ECjZVQHTWJnvXIvwQdr0mxuMiK2AYcU+3ww8gJ5qhhLTEFgBfLHKUF
         4x8IqAc0LFI7axC8Txq3QJ43LU7aAASzG3zJwdOt2FmVXcJza2GFMhpi3dJJCUSq3pGC
         0cqSTHekUPvTpfhPH7hTT0kyi5Trg5pFacKQtUNFSVjTWc3yayOM68pX1uU6mJKfrCap
         RKvg==
X-Forwarded-Encrypted: i=1; AJvYcCWv0+JCPIZR/Ahe5Ok7kDQlaSmfs0i0hAhH3QeMgebY4j2KqFurjGsItApwwpjbGwgIf2FsHzYKuMKuLPsIWkwSpbhEkeSFFRfndWE9
X-Gm-Message-State: AOJu0Yze7s7bUjd1Pmgx3ZyYQaNlQMQOJNJDZcIh6GGxDQ8pFs2U1NHz
	utVv/NeeM264+siLOxAEJwRuMhU/vs5w5qJesJdpMVuM9LkgeruoEUjxdqtOuXU=
X-Google-Smtp-Source: AGHT+IG9aAumHt5LgoqTOtyw62prfZf7AwHJmiSCCsFccmXwsxBBdagmRPhV1gk0RVZYG8ODVR8BDw==
X-Received: by 2002:a17:902:c40a:b0:1fd:65ad:d8a1 with SMTP id d9443c01a7336-1ff37c0c7d7mr15737105ad.21.1722319572373;
        Mon, 29 Jul 2024 23:06:12 -0700 (PDT)
Received: from [10.84.153.104] ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1aa0dsm93047105ad.187.2024.07.29.23.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 23:06:12 -0700 (PDT)
Message-ID: <85bca797-6ddd-4541-ade5-a75864870472@bytedance.com>
Date: Tue, 30 Jul 2024 14:06:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] psi: Inherit parent cgroup psi enable state
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, surenb@google.com,
 peterz@infradead.org, chengming.zhou@linux.dev, linux-kernel@vger.kernel.org
References: <20240729034100.1876510-1-zhouchuyi@bytedance.com>
 <dxwvcccihuuxddycohyi5dj66o42rjekmkgxc7pzs344kvwuhd@3x6e5prw3xld>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <dxwvcccihuuxddycohyi5dj66o42rjekmkgxc7pzs344kvwuhd@3x6e5prw3xld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Michal,

在 2024/7/29 19:37, Michal Koutný 写道:
> Hello Chuyi.
> 
> On Mon, Jul 29, 2024 at 11:41:00AM GMT, Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>> This patch tries to solve this issue. When a child cgroup is created, it
>> would inherit the psi enabled state of the parent in group_init().
>> Once the enable state is found to be false in the css_populate_dir(), the
>> {cpu, io, memory}.pressure files will be hidden using cgroup_file_show().
> 
> I'd consider such an inheritance cgroupv1-ism. Notably,
> mmemory.swappiness also had inheritance and it caused some headaches
> because of its susceptibility to races (cgroup creation vs parent
> configuration).

Agree.

> 
> What about adding an option (mount option?) to determine the default of
> per-cgroup pressure accounting?
> (Based on reading about your use case in other mail.) With that you
> could only enable it for the "online" groups of interest.
> 

Yes. We can add a another mount option to disable the default PSI 
accounting and enable the pod we interest.

Thanks.

