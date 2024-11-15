Return-Path: <linux-kernel+bounces-410985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F789CF138
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E74C1F21A54
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534AA1BCA19;
	Fri, 15 Nov 2024 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sij26OCf"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5138F1E4A6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731687492; cv=none; b=YCcz+lO1cDtav1rft/YzckfJP70wiciGXLpwngrDmN0NrR1BRg71flBiOCirI5qn2BvThfPzIUvKAbvVgwSmlnQEyxW2F1r35nsX//3ddyvhn792JKcyf4ZzJ2ETMaK46eso51uSvOKf68Uv4syJVOe1b5GWFlqnL/MBU2AfWHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731687492; c=relaxed/simple;
	bh=CM9WKM5eaFMdjpGiqPcyzdJyelqOLE7qnrLH8/+PzNA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BufS3s7C9DtKcDDIxGj2Uuqgot38cjlqbT0LAEP5UI5o/Lgwql0WeFSCLfqRhQt4o/2flbr6ixD0hrABFo5nA1gXA2Fs8s/PpGszehVGSIjza24BPyrDVqI95naVcrnrRqDDSebtg+qRDQVuLTOYOro0SrlXU6DoARk4fq0vPG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sij26OCf; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29609ec9437so1117027fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731687490; x=1732292290; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VPRAwnJHM0yj/wQYaOzcRH9Aml3wNsDwQd5Odhgyr5E=;
        b=Sij26OCfYcbHVw9uu/qqdkCDtHMdmmotPo0Gwwe7FL1+0N+yoLwouhW2cTHQnW+UdS
         sY6wmTmoyoW63OtOs7qy5Hai1YSSgOcohHRdTqjbHLoxHnKp0ioyPK08K9iCWo4pqBmE
         gjYANATrmsBCZTJsyCPWViQnngifqunFtdJlidKiSqyyF/tA+ucwCX/Dir1aTAd8xzJI
         5/ZGqug0cppSghcP70/m2Jriddcrgas00rPIwGP/rjmquKp0X077jUk4Z6ukvOwzGVWX
         8t45VIisOdbhIWAwdKihz6e86G509zQYASCoIXqa20tOoizKKZM9MysJMJ0fXMavU0fj
         2eQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731687490; x=1732292290;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VPRAwnJHM0yj/wQYaOzcRH9Aml3wNsDwQd5Odhgyr5E=;
        b=uspfqSpW/+RqUvkeDeYR6Xv9wzHI0NuJB/vL8sxKa8s+gcsDF0aTp/bWeUkPvHvmzQ
         Xt3DOExh03kuT6HyNwIvbnci3RQchH3mQVaBTO7XM/1x5/o65QPpaKwI0tXouggcW7PN
         YshciAcp+fB4DMWRbd1EcqyJcBxnPzceuS78MgoNrXkiD7BAomICez6bfpQjmTzV+09P
         SnnChl+J1vj8TetlOTD5jzNWglIvK7dl4jLm0Oz/ciBBjqLnZvszEsCExyVBxVu63nGf
         cD0QGkDFPSZ4tYM046nbMeY7R+i33ysOZqwTKAvZWFpI/vkYRZjIqt32WHkeUa5N8wtF
         iiwg==
X-Forwarded-Encrypted: i=1; AJvYcCVhVPfS+xiKfSAghMhsTPBRaijQ80ZPtmEZvQyH36JBMxFldfYpTqatQYoOMiEcdUwdgCpod50KcdbeJzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuG5ztJWRLRafSnXxdF9Qu5UvHovfHApApwljpbzO3QzwFdnZF
	A1FHgUnAzK+scMxTT2PL22eZWVkffv4ucjTQOpM2+nPxwHeXcHlCv6XxKNgc30LxCArGu/xajxe
	p+NmcxuPlJx/kV5oFN3RVjylDRSw=
X-Google-Smtp-Source: AGHT+IE9+YBPtz90EA5vahfB4doZw05tN4zdOuX4MjcdEQsaAEpBNOp3vCbB76uabHJLVwdiceHO647zyF3zr9G7jSA=
X-Received: by 2002:a05:6870:1cb:b0:294:cac8:c788 with SMTP id
 586e51a60fabf-29606a062fdmr5454685fac.6.1731687490275; Fri, 15 Nov 2024
 08:18:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Fri, 15 Nov 2024 21:47:59 +0530
Message-ID: <CAHhAz+i+4iCn+Ddh1YvuMn1v-PfJj72m6DcjRaY+3vx7wLhFsQ@mail.gmail.com>
Subject: Help Needed: Debugging Memory Corruption results GPF
To: kernel-hardening@lists.openwall.com, 
	kasan-dev <kasan-dev@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, 
	kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I am encountering a memory corruption issue in the function
msm_set_laddr() from the Slimbus MSM Controller driver source code.
https://android.googlesource.com/kernel/msm/+/refs/heads/android-msm-sunfish-4.14-android12/drivers/slimbus/slim-msm-ctrl.c

In msm_set_laddr(), one of the arguments is ea (enumeration address),
which is a pointer to constant data. While testing, I observed strange
behavior:

The contents of the ea buffer get corrupted during a timeout scenario
in the call to:

timeout = wait_for_completion_timeout(&done, HZ);

Specifically, the ea buffer's contents differ before and after the
wait_for_completion_timeout() call, even though it's declared as a
pointer to constant data (const u8 *ea).
To debug this issue, I enabled KASAN, but it didn't reveal any memory
corruption. After the buffer corruption, random memory allocations in
other parts of the kernel occasionally result in a GPF crash.

Here is the relevant part of the code:

static int msm_set_laddr(struct slim_controller *ctrl, const u8 *ea,
                         u8 elen, u8 laddr)
{
    struct msm_slim_ctrl *dev = slim_get_ctrldata(ctrl);
    struct completion done;
    int timeout, ret, retries = 0;
    u32 *buf;
retry_laddr:
    init_completion(&done);
    mutex_lock(&dev->tx_lock);
    buf = msm_get_msg_buf(dev, 9, &done);
    if (buf == NULL)
        return -ENOMEM;
    buf[0] = SLIM_MSG_ASM_FIRST_WORD(9, SLIM_MSG_MT_CORE,
                                     SLIM_MSG_MC_ASSIGN_LOGICAL_ADDRESS,
                                     SLIM_MSG_DEST_LOGICALADDR,
                                     ea[5] | ea[4] << 8);
    buf[1] = ea[3] | (ea[2] << 8) | (ea[1] << 16) | (ea[0] << 24);
    buf[2] = laddr;
    ret = msm_send_msg_buf(dev, buf, 9, MGR_TX_MSG);
    timeout = wait_for_completion_timeout(&done, HZ);
    if (!timeout)
        dev->err = -ETIMEDOUT;
    if (dev->err) {
        ret = dev->err;
        dev->err = 0;
    }
    mutex_unlock(&dev->tx_lock);
    if (ret) {
        pr_err("set LADDR:0x%x failed:ret:%d, retrying", laddr, ret);
        if (retries < INIT_MX_RETRIES) {
            msm_slim_wait_retry(dev);
            retries++;
            goto retry_laddr;
        } else {
            pr_err("set LADDR failed after retrying:ret:%d", ret);
        }
    }
    return ret;
}

What I've Tried:
KASAN: Enabled it but couldn't identify the source of the corruption.
Debugging Logs: Added logs to print the ea contents before and after
the wait_for_completion_timeout() call. The logs show a mismatch in
the data.

Question:
How can I efficiently trace the source of the memory corruption in
this scenario?
Could wait_for_completion_timeout() or a related function cause
unintended side effects?
Are there additional tools or techniques (e.g., dynamic debugging or
specific kernel config options) that can help identify this
corruption?
Any insights or suggestions would be greatly appreciated!



-- 
Thanks,
Sekhar

