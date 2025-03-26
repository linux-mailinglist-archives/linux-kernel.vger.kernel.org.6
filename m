Return-Path: <linux-kernel+bounces-577405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2E0A71C9C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27B23A5284
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24AF1F8672;
	Wed, 26 Mar 2025 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VE0zrHam"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718FA1F7569
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743008496; cv=none; b=lFZhpJGx5fZBebWuznjXH1FmPfjLKPnAjtM9DFnTlU6dMKV4wGFLTym3BcBGhKUjTB28zbGphBivssAdtm8MIzYN2F+FJG8Hs9PMlovL69Zhm8KOwB5UpXQNMqta9htQX3F8NFhEjVEV7clzHafBGq8/xVKhvpuR6WmfE7lg4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743008496; c=relaxed/simple;
	bh=m93JNtthltSSbcTrFMDYov9U0XPQF5pmKwirD1tHohI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBZH/xLjqZQSoE1FChHdFSDBqZnaFfMm6C9TKkRwCq8g4qQ8vlJjsDVCyiH3mYiUPtBl/bsEknUaQtMUbcT03Bu+OhF0Am87q/QNehPAiN133aBJ/G70kRHWx+YPlraqT6I0OXD0sh7BPnwBewNioK5Zee9WOmujvpPo0ByYUCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VE0zrHam; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so1602a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743008494; x=1743613294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m93JNtthltSSbcTrFMDYov9U0XPQF5pmKwirD1tHohI=;
        b=VE0zrHamGe+C/d7k/sAqno8unsnbmEBOPZCITxs9vLuILC9fvtFwAOEJRDchwfGOuR
         bamBdeLp8PEI28zs8kn8VnnspaIBZmSnWWd7si4b3v0H5W017omAsDb2DwctB3ErVfZZ
         z7Lpbmd1rIb3tDZHjqkUsf9dCKHPFeBjpOAnz2AYADCm0ELhkIVRCQy2genzjbuGNx/W
         5W2HRHe1xdn3p+6FLBCs+wGB21onG43YZFrkYnxFHuhiEbSp0ljKNDF5QBaPBIJE4xjd
         M6GB2PImLW+zMpoOpnVa24u4WKGDoAPj88JbY82VcBYxvSBoo01YxbQobcoZYRKbZcgU
         WCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743008494; x=1743613294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m93JNtthltSSbcTrFMDYov9U0XPQF5pmKwirD1tHohI=;
        b=q8vcBbEz4FS8Dv6NsgGKd+kQ3xHYJ4gcXNs37IWkbq+XYmDn8bHn3Bp2/SmsONQgJw
         TE7pysefivCC56qMHgoc7loTnKDgWH9jPRr3NgQh5tbmBfiRCclr445TO0X3wqxyIUc7
         qSVjsxYM9HVzzwuc5CZDA/HexX49rRGTeCHnrlyWg2lN5PBoWy/qTxCa9bK2iDNY5GTX
         YDxVS+3HFROB4l6jspGuGoWUa2Emrd3UnPXQPH1R44kS6ZC76ZLfzODRsY2h0InYtJFP
         KGFnMusq+PxGkbyeaBc9D5vQOWY9VpJ2umLYl8MLG8bCpKWimye3RMUCAh1qq723YJcf
         5kmg==
X-Forwarded-Encrypted: i=1; AJvYcCXIxXY5n1zRQ6dSKq+Y3l22Jz0loJI6mx+nkQ8Jffqk7+vjIL5LEVv/Sj920pWpCvxE4ZiwDP+8QeCyYPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6E3u6HXsQ/ZskQ6QB5O7qVGqYuC6mrXX97qetEhY0H/jgBtW4
	VTih/wXTI24BRg5LzyiIUjl8K2u1ihK5mvEUevXQ+H09vzKiGeOTeT9DuKLFALqu0r8pbSqNSye
	TRbO2eol4VZAt8dihoJORl71OLDCkr0/K0b5UIA==
X-Gm-Gg: ASbGncvZ5nwDfppM6cVr3vrn3Oghtl8Y3bBcpOQnu4YO8x5I9LUKWsCo7LJamhi7pVH
	nvhKNrnPrC2JC1Lp3eU0pc59aOsWEv0PnZsetV4hpbyC9zK4ORJpLhEPyM3cFOfIjW8Uhz5kgE7
	NBPPebCV1Ap+flkwFzMsHAxAYF
X-Google-Smtp-Source: AGHT+IFjVsGE/uI55/GwMic0rGrb/4ccYRlzq+3uz57glJBeCVvxaKFA7tRt4tikiIMHIU3n67/yVuVxuutCCLJ6PoA=
X-Received: by 2002:a17:90b:1d8c:b0:2ff:7b41:c3cf with SMTP id
 98e67ed59e1d1-303a83c306fmr191288a91.4.1743008493555; Wed, 26 Mar 2025
 10:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325143943.1226467-1-csander@purestorage.com> <5b6b20d7-5230-4d30-b457-4d69c1bb51d4@gmail.com>
In-Reply-To: <5b6b20d7-5230-4d30-b457-4d69c1bb51d4@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 26 Mar 2025 10:01:21 -0700
X-Gm-Features: AQ5f1JodO_70bFedzA9NLOdpPN9pHRVHSWvuZt04JDJWrhv2Dx7TEG-gTyKLrrw
Message-ID: <CADUfDZoo11vZ3Yq-6y4zZNNoyE+YnSSa267hOxQCvH66vM1njQ@mail.gmail.com>
Subject: Re: [PATCH v2] io_uring/net: use REQ_F_IMPORT_BUFFER for send_zc
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 2:59=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 3/25/25 14:39, Caleb Sander Mateos wrote:
> > Instead of a bool field in struct io_sr_msg, use REQ_F_IMPORT_BUFFER to
> > track whether io_send_zc() has already imported the buffer. This flag
> > already serves a similar purpose for sendmsg_zc and {read,write}v_fixed=
.
>
> It didn't apply cleanly to for-6.15/io_uring-reg-vec, but otherwise
> looks good.

It looks like Jens dropped my earlier patch "io_uring/net: import
send_zc fixed buffer before going async":
https://lore.kernel.org/io-uring/20250321184819.3847386-3-csander@purestora=
ge.com/T/#u
.
Not sure why it was dropped. But this change is independent, I can
rebase it onto the current for-6.15/io_uring-reg-vec if desired.

>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

Thanks!

>
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
>
> Note for the future, it's a good practice to put your sob last.

Okay. Is the preferred order of tags documented anywhere? I ran
scripts/checkpatch.pl, but it didn't have any complaints.

Best,
Caleb

