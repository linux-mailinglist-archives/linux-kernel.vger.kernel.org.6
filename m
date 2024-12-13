Return-Path: <linux-kernel+bounces-444929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCE89F0EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D022828E5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEE71E0DB3;
	Fri, 13 Dec 2024 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Vn/DV3wt"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60541E25E7
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734098994; cv=none; b=I1Ac6S3C3bAeTmFXi5f01wLF8YBcInTH1z9VqWqxtEeWOT/5gCDyIBu3WL6yqEQzTxyh9F7YS2i1Zr+NdQLm6Bp+3EbQJpPl2oHUaSZecc2vgE7IGNqt1TFRaBqUqwxHhRRtdhkKD8Ec6y8AqBR7xNIVo8sqdp8Rv6K0CVr9g9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734098994; c=relaxed/simple;
	bh=Z4k204suA60/SXJuVjRwwHu5G541O7oLWa1RT9V0WnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IklatAGS0ZZxn+KVUPiPk+qv83CK+SfXK+L9JidnlX+bWhYxEL1VZwnQFh4COk1iz+2A5icWtNjyzxuX2kl03xIp8Z44rn38s9KgO3EBpDQF78A0V0WqqALTIbOTFu1EPPBnlPR6WB15OFwBr8O3VJifhR4MmRWb//PeIa3C1ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Vn/DV3wt; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844d555491eso61779039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734098990; x=1734703790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zWSFlALklVPWBvuhYOI1ONlxQ38UgxUHGcn3LfxanEU=;
        b=Vn/DV3wtc/ogxNV6n2/+2nsw3tHZKk2PY00DIkiBRDa8Y/p1HaHpnk6g42NMHk3jbA
         4lTjdxYJwrYDr3Dcb+g0or85oQIvmCb18gZL1TDmV4yP3Bet1W252zlBiCZ2BHHKeM7i
         9cfssRgsYSGdf3OM+pDd7rSlE2R8kPY2nhKuLUaXhzMJH37MzGGMQ5E2CzLDUNvryQHb
         8YJFFqGp027b8UGhn2dWkI3G0AoSz1vO5TF71gWByjp1+UUNuPJGNvKLZiYle43JGcUi
         jrhhWU1hW1amrzd9wHOTF8SHHKRo2yihL+YVzNs2x7fMef94OQ7hRjzQHrsKqAT0XfxN
         3FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734098990; x=1734703790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWSFlALklVPWBvuhYOI1ONlxQ38UgxUHGcn3LfxanEU=;
        b=KeRcADtR/+Qxwldo/G7IZJQthvcoVeDTyhEBhrKfStEdtPz0ruKsxXCW3vttJX7N7d
         kv2LPrCvyGq8+jj7CrRb+SI1NkuNYmCor1IzlcD3+EqdH2k6/HvH9lg05cOrc5Alk16N
         E+Uxq2pFG7i+YLHn5X8VJbHcGWSePpY+3l++xnn2dftcBgQ0mrozC1Bc0YKiwGVBLtdt
         KADM0w7juuVu6dhRvCJoEXhFHtkoz1IG1ZowUlNCWMWPmTMxRWCfzKz4bTiJukPFXid+
         Hdo79UBNd0o/PHSjEJpbfJfQsq6Ii66jNSUV5QgHJLsziBoRG2dsj8FJQpx9wmhI7gds
         PNlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8wFjbFlD5onBzheJFbYav7iQvUKWyYclar2RSvMWsfEVW1aiHim89FqfYGRXZpR6cSrsblKHAQlth8Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi/r1VJSfPPkrIODCmv9L3de/yRVO08s5qFvp/4VpgxkqEvJvB
	POaN2GJ5yC/OVnNlyDp4Xx+q5mgMnEyTjsy9NPwxwxJacSubGsaCNY4FzYL5cbo=
X-Gm-Gg: ASbGncvmpVUWZDOgqTe260hkSpSdwqvdPZet9x5Ap1H0VvUYNWYN6QXFuDgsaXBuGZW
	nWva9jH5O+BT5D2199wZF6BZ6hb5KUiHr9qKihvGQX8AoXCu0mg+LqBBVyzlL1OXrNTpEe+vX4C
	65wmLm5AyAHHtuPPLy5KDj4iGp+06tXJtbg5iRV0Q4hnvCa5kBWt1fBei+OBcm1nB/euVSAP88P
	0ikfWJfz5fd30K0I/W4DPr0xIvKTrXAVcg9ZLglGeo19a/W2yCS
X-Google-Smtp-Source: AGHT+IFxfLsEYNSzt1ijeVP2axPSjVHTMFNfMKOLhfeGPGhogWa2tIb3yIz5mXqPGgr0csMBvr1Vfw==
X-Received: by 2002:a05:6e02:13a5:b0:3a7:e0c0:5f0d with SMTP id e9e14a558f8ab-3aff4616f35mr34733195ab.3.1734098990648;
        Fri, 13 Dec 2024 06:09:50 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a808cdcdd1sm50139615ab.0.2024.12.13.06.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 06:09:49 -0800 (PST)
Message-ID: <b4b2993e-1684-47b5-b8d2-5ade368c6b28@kernel.dk>
Date: Fri, 13 Dec 2024 07:09:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [io-uring] general protection fault in io_register_clone_buffers
To: chase xd <sl1589472800@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CADZouDRcO6QORhUUHGRBQvZ_q8nip0S+Mn4Hb61W8zi_OfmSag@mail.gmail.com>
 <85c4b3a6-559a-4f1d-bf2d-ec2db876dec7@kernel.dk>
 <CADZouDRVN0eVMNXDPX9vSGXYbOPSHRgspWz20VO4fzNeFq18ew@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADZouDRVN0eVMNXDPX9vSGXYbOPSHRgspWz20VO4fzNeFq18ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 2:39 AM, chase xd wrote:
> Sure, I'm glad I could help. The kernel no longer crashes after this
> patch, so it seems to be the right fix.

Great, thanks for testing. The fix will go into the next 6.13-rc. And
thanks again for running syzbot against the current git tree and sending
reports, very useful!

-- 
Jens Axboe

