Return-Path: <linux-kernel+bounces-525252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237C8A3ED19
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EED918893D8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773AB1FECB3;
	Fri, 21 Feb 2025 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="kPwzX8ak"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C45045948
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740121057; cv=none; b=BgFSEtWX/KqNdfDR+q2E2CoWbjjNQnlAo+oqumivNGieUiWlOK1jqlx4va0kKSjksvOztlixa7wDpz7wFCxgJ+HHvafE6rXgwMDl7kc/YRzHkMLm8iZJ6dKIS0f1BAE8cKIbWKuBDAAYcy+/+UKgRabaswkoJHgQVWwNJY6j3xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740121057; c=relaxed/simple;
	bh=erYvI6PmzbgE5N8f/6/wN3MQppJX8jHRkv1BdFa9Sko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S95CuCzAJv+nz8whLYpZNHU7ZRgwx07hn9r/KXr2aiTItiZv2dG61Lx1Q2N1E/Js/P5X34Ne42lEBtADe5PgmzRipvox3AaNYjOWrbqXW0fN05SfJ5erd/eIXBnC/ABMho3mSlLgMP8nG0OYstQKyfe2rN89uIu2h8JE30YUW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu; spf=none smtp.mailfrom=monstr.eu; dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b=kPwzX8ak; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=monstr.eu
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e04f87584dso2704632a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1740121053; x=1740725853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HIJDwKea4GoDru+S7UHNrDVRE73FZnkbCFdJe5uCGFg=;
        b=kPwzX8akZdchaq48WgBqWBCUlG/YKyJBityUx/2R6ZwCh4i73qq9JjHnfEI2EV+GGq
         u9Hhsq+vLWQ8miX/bxrQUbd1xn6xL5fsmLrix2HXaPI2K4FKCfwKTJ57d7irI2s8uxNk
         Czx50yaO2yEE9M/Ccv774S6rcBt+VnlkoThC1ChXsgTYVokD+/pMgHn1x3qSZWxA+5Pn
         dIzgDMSKqZu9aYJ9sDbTGal0hycXCKP2tPOTAZEzMqVfGZ4XRaQ9ykQAnf/eE27K2T4o
         7NKk5Z6IlzWNOYON0wFpy3D2aQSD8LE2zSnHktzwXoR4RR/ZOFco3vGfM4LGCsodV2xT
         fJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740121053; x=1740725853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIJDwKea4GoDru+S7UHNrDVRE73FZnkbCFdJe5uCGFg=;
        b=FjR3RFoYK+L8wlvHc6VAMcEy0Y61OAZDSbjaKzXkZC9J8Me134K/4+d1TfgE6ugCcw
         QB2PRyFBmZr7XjwGJoP/IJw8lEhhk2NrNbrDBGhrQrQLmUKbC9SvfpiGpYRnYdGgu2pM
         oZrjsgksQdNoOx0/qagZWm9tje3wvVW2Ky3tyV4jPEAukgG39+NTg3BdBLqbg375YhjG
         qNEnPrYYT/sE96ixlelW5/T1ns6ZG4MFucPkyI+taU6Yt9LH4QGalmsiQwPYN4r6oDP6
         uRqWKAi9Q10mfQ9RxdGzw+QM15p3Gm7VP7oAs/XrRna5j+8WCsq9Sn29rCtLYtlhWOQE
         0soA==
X-Gm-Message-State: AOJu0YxxAVPcsNvPpWnCQOF6Wpp03FxFGHQwYwXGC8HwLQpIpNbFg/MY
	ttydBt714oWlfdGDAanO9f5boaNqdtyH9UjF/q9ldL+myDEJxJN0f21GcEqqvA==
X-Gm-Gg: ASbGncuFV1L1z/0Z82m/b5gqXCNvPN2mnEfVfT+6o0d4UJIgzEPSX7aVYftqi8UwYEM
	chiAjEpv5N0jpFmP9PALThEnzhGk9EViSCLn0juq4OQiWIy6PYES45mbBn2M78zMgb5isVUHnUQ
	+XQHn8sWk27NCdOxx64JT7GMArqAL3dHeFt7N/SIGYzJmri10OGf9DTLmbmUmZM39E9BesOt3Or
	atbPncyWeq4xwiIUnUMwb5zuCxx8sGfluH8b90n6wIPP/ty5xYrz3UpJ5ByK7BmRK+sjBLkrfDv
	/5myV2ZmbPkL3rWm6/jVA115XUd8wzCWL4D8d22O2w==
X-Google-Smtp-Source: AGHT+IHKFajgkMgZoX1TBQohgMrnwkgeinEfkxDxJfoqRWRenecHkSDaDk9IPh4TRSIlxqzKAiDJ2Q==
X-Received: by 2002:a17:907:7d93:b0:ab7:e811:de74 with SMTP id a640c23a62f3a-abc09c27023mr206944466b.35.1740121053300;
        Thu, 20 Feb 2025 22:57:33 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb804fc0b3sm1136947166b.11.2025.02.20.22.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 22:57:32 -0800 (PST)
Message-ID: <f7663dc1-1897-46cb-b190-cdf66485580a@monstr.eu>
Date: Fri, 21 Feb 2025 07:57:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patch in the battery tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Sebastian Reichel <sre@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250221131040.7fe8b838@canb.auug.org.au>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20250221131040.7fe8b838@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2/21/25 03:10, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the xilinx tree as a different commit
> (but the same patch):
> 
>    a944cfd799e8 ("dt-bindings: power: reset: xilinx: Make "interrupts" property optional")
> 
> This is commit
> 
>    5894be9685db ("dt-bindings: power: reset: xilinx: Make "interrupts" property optional")
> 
> in the xilinx tree.
> 

Thanks for letting me know. I will remove it from my queue.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs


