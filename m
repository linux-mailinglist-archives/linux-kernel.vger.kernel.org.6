Return-Path: <linux-kernel+bounces-576012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDEDA709E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E01189FDEF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0010E19ABC3;
	Tue, 25 Mar 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="a1xdp+ZG"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AAE19066D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742929107; cv=none; b=vGPLIq0b/RngjehUyNRCbNyH8SRTPIeqI1hhVzszYzBmTuF/ZHQurInRTTMjuWq+Umvwka/9VdWqpfo5a7cXZCiRouUSbM1uYy4hvKzIp1kD74PUc2e5BXTbTbJaA+Og80OdBrkKLjCHFGQcqEm1ZWrWh/L/Ak4Z3OKWhrrQdus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742929107; c=relaxed/simple;
	bh=G1YAcC4oYWB4/r78XA3fcH0LEU2AW/3uYFr/Fl4ZCyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lzxCxzidUnlk6SFJOPoyeAPNPbPb3kPTEU1vEH94B+OTGYQ7MHkt/ToUjYROpdMA7+EFQiBtQsKb+xg+AXR06K+xyuZeGeyeYdzFcGDwHGAiwvSf5HgRofeUdZY0YncdGHEiu/lAfkUb0kQvqyE7eagarooD1l4LukHfmPRhDA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=a1xdp+ZG; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476a1acf61eso55460491cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742929103; x=1743533903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F69U26acXd5VcG/6G7ZTYcIFn0jZWzh7OAN8m7VOJ/4=;
        b=a1xdp+ZGlMdiL7D8CoQznvf3C9drH5De9KC5yjlzsZDHBCqeHM2OgfPTOI80KX2GSt
         bWNR0GKSaOahXRmpD6m1xeowMEIqwGB2GzZIvDm2yBggaXSnYmbjduWPCEknSkPuEnEw
         furjquTF0KWDsqbr7FaxKOGYsTHn0Mwkq39vlfEH4F/w/TWxF09ddlGikCaVWslhF6a+
         fsF7h6/3lIS/xZnFhHkADcLcKeGk/5U4tn7jvLJWduO3Kaockd3AiAobu4yCOl11B+We
         I3xusfAR/0AE4S5RbkFHkkfZ4xKWk7d9Duxj5hTYk4FBCJyx4tKZOvOMzjX+q2/Shu/j
         ODHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742929103; x=1743533903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F69U26acXd5VcG/6G7ZTYcIFn0jZWzh7OAN8m7VOJ/4=;
        b=Vh78i/g2UoBn94MlsCzJeTW5/24l1lH0/Gn9OrpGgFvsErveXWfsQzB+8UbuuaTE1V
         vSwL5YhTiH/WV+RFGaAXC45s7x0+dDstDlL49snt4gKfU9t6/20cSoM4r/rGJx6Xm3Ra
         NQjRe9HVxLjeqaqdrP7oIeeJ9G4nHClfrkLwnNLAKIzqcL0EqizFgZUYyEbpAkJyFhVj
         SJ0IjaHfQh+VYgy9qhQJBfh0ew83oLT235Ud4dLEC5u0BPpuqT0QrIlRYA+DtCWsed6m
         nCvwT0OuoaYE11JlgJzb3ZZ62DMW7ErRw95vDD18QTGd7RMgyZ3YXxO65h1DouW8z07W
         SQEA==
X-Forwarded-Encrypted: i=1; AJvYcCVnRulX1buL1hOl5N/8EPkrUDCHyYaWI5hvxwR3uD06KiZvzM1AT6xaY+ruFD8YP/pTkTZmJuT7Ng8Ig6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD2uExrY4wVo/WBxQghpkzkJlVkCKtVD++CIydmw1gu1EuYt8y
	WR6sRtl1PmVfaeK9oDHqwPwRyO1uopAvkby0ILzGLNZWcLaYq8uPY/HUacvK2l8=
X-Gm-Gg: ASbGncvb2liPFUXx929Cj+59ZHcgxmkhHv7SxpFk/2IxcImtddKHOZWydJE/G8qUQ6A
	yFd83FB9/0mYcdqg3vm8beqPKWhrVDGH5AbeqhL2aQeWeEdYjyylgiPC31QEUnP0Nw9uvrpey2w
	CuR1dcoHSUMKdYDEbjhVgedz9ZR8cMrnATPSUJl620aC7x9dJihDhp6lGcSBVmom2fEk0lObnSI
	8ph8+LUNGY9n9AUfCYkQkTXnSPG8dcJy9SrnNoc22NYyE1vvRs8o31tIW5hIqm4XZ4EVqyAGrg0
	jeHOG+7unLYe0fZSWXIJxn1X+w0dpaafjh3FIls=
X-Google-Smtp-Source: AGHT+IHvWsG8m93R7uiuaOPtMucj/B5kGTm35rhLrBGf6mpL7oN3sUEZC29YL2U06Nknleuk7BUPjw==
X-Received: by 2002:a05:622a:510c:b0:476:b02d:2b4a with SMTP id d75a77b69052e-4771dd89611mr338018661cf.27.1742929103439;
        Tue, 25 Mar 2025 11:58:23 -0700 (PDT)
Received: from [172.20.6.96] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d51fd76sm62396571cf.57.2025.03.25.11.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 11:58:22 -0700 (PDT)
Message-ID: <e5c92971-1d29-43cf-935f-6074bf30f72a@kernel.dk>
Date: Tue, 25 Mar 2025 12:58:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] WARNING: refcount bug in io_tx_ubuf_complete
To: syzbot <syzbot+640cb22897e59078196e@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <67e2fbad.050a0220.a7ebc.0052.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <67e2fbad.050a0220.a7ebc.0052.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: io_uring/net: fix sendzc double notif flush
-- 
Jens Axboe


