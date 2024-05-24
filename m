Return-Path: <linux-kernel+bounces-188290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB178CE018
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C073A282AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CD8381D4;
	Fri, 24 May 2024 03:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CgMJGQ3x"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88FF376EC
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716523145; cv=none; b=S/IOz5e2mPO1hir1SPywYDRiuMsw3IR3zVKwLQdrqAH99BvH993NdgOqVf3BLwQyw+RbduVOGEK80j1a4bklNQHKz/8ACF1MMP2YN80LZbYUFR1qj3psXgXest79N7oDMkyH1qKJYL23iBiXShxlc5HOM9rVUQNHIuEMOm0lYKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716523145; c=relaxed/simple;
	bh=WJDAY7lerQtUQ+7FfK6NVC1yguwzqLbVVXPIzMDiAQg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EV/yKesPuBD/gWaEvp35HMhE/uONj1dgRS/jpeqGF85Cp5lUPtRVBubCf9svT4kKuJrKmz2r5vAJppea5Be4DSeXP4q31OqLcGWOcGlfoZ6/7VIu+J8VOC95uo6xBAbJArh+4lve4gZD9TIV/l1uUTmp0VzM5kD3RZXk4lX72YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CgMJGQ3x; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-529614b8c29so542234e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716523140; x=1717127940; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X3+8ksvQtbMC76q5Nc4etD9X+wAuntsU/04GYy698ME=;
        b=CgMJGQ3xi5HhuYoDuAyanSr8F5D9L/sR4f2KqaquehTFw3fTdhPnShOkXv4xcAGwEF
         PaqsSREUA5xxEU0SHdARZM3p1BIAM+JoeiLKLRJdcFElRlaAY2K5s2pSIHfhzL/lqlxW
         g/r9vaMFwP8aeZkpS6WAmlo9+WMVnAeX1nCDJUASWSk+lqlNI7V3IEM+u0FxGNfMSWgO
         CNzFNCBSKdRmtNusOnyLBps7WRjo9PnIAeMlyrZds9SpEQ6xOMkZv3860gHfTmpxYFa0
         proIgRMWAJtKqNDWtT123mCtEZCkVtQnPN6l0ZYaOzAO+NfbtC9NtfPZVA0zqMQvlqBT
         8CUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716523140; x=1717127940;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3+8ksvQtbMC76q5Nc4etD9X+wAuntsU/04GYy698ME=;
        b=Nsro1/nhSGrk/fRXf6hJzDKewJrseekEqVvyJhlB/P9elOHVb9zCEoTQlLhz/KtPtO
         sXJ1+1aTCYbmnYXK3txVyKY/YT17mm2tjDdOxsOLaden1sxxvCo/vUq3VNB9uHy8olnV
         YdunT1OPmBNEr2DCFtR7cSGOSv4R0XveDXkZ+3E+m4erSwRnwxCjNIZmU68j+ncL/bv0
         RRyuA41iPf9Kxyet4Eu5znZMhZadEHnLfTaEcaj2uFkp2z/gzDIYZQ/sh6Xy1W8gCyIR
         4pdwfOrSerxtj+Z+6EFg0ZJ2lsJaH4IZ2smPTp2FWnejbL/2F5EgWgSwAT2P496DNCNG
         m+zg==
X-Gm-Message-State: AOJu0YyMl2vTAAI4KKp7U8cyXblN5Ft3He8ke1+U20sDuHxULk4ctws+
	baXw0g2NP65qimV2fV6dlpv8qn5HxTbzdwCzYFJx3UIFWZCRdz8tuThZkvR6qi4=
X-Google-Smtp-Source: AGHT+IGVzRNqtizZ7IUTjH3NU3eR1xm2q8rCZrjbbFDjWjh3YHWKAfmZxjBF4s9rAO5ITzWdj8RjKQ==
X-Received: by 2002:a05:6512:2091:b0:51d:605e:f0ce with SMTP id 2adb3069b0e04-5296736bd69mr515051e87.50.1716523140026;
        Thu, 23 May 2024 20:59:00 -0700 (PDT)
Received: from u94a (39-12-41-105.adsl.fetnet.net. [39.12.41.105])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3737c29dc36sm1348935ab.5.2024.05.23.20.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 20:58:59 -0700 (PDT)
Date: Fri, 24 May 2024 11:58:54 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: cve@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: CVE-2023-52793: samples/bpf: syscall_tp_user: Fix array
 out-of-bound access
Message-ID: <7p643u2dcn6cen32dbtrcki62qrn3o2hyiplbx2hkpcojuiev5@3hbnkswhtha3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, 21 May 2024 17:31:29 +0200, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> samples/bpf: syscall_tp_user: Fix array out-of-bound access
> 
> Commit 06744f24696e ("samples/bpf: Add openat2() enter/exit tracepoint
> to syscall_tp sample") added two more eBPF programs to support the
> openat2() syscall. However, it did not increase the size of the array
> that holds the corresponding bpf_links. This leads to an out-of-bound
> access on that array in the bpf_object__for_each_program loop and could
> corrupt other variables on the stack. On our testing QEMU, it corrupts
> the map1_fds array and causes the sample to fail:
> 
>   # ./syscall_tp
>   prog #0: map ids 4 5
>   verify map:4 val: 5
>   map_lookup failed: Bad file descriptor
> 
> Dynamically allocate the array based on the number of programs reported
> by libbpf to prevent similar inconsistencies in the future
> 
> The Linux kernel CVE team has assigned CVE-2023-52793 to this issue.

I would like to dispute this CVE.

Files in samples/bpf are meant to serve as an example and not code that
are directly used at run-time, hence I believe this bug does not have
security implication.

--
Shung-Hsi Yu

> ...

