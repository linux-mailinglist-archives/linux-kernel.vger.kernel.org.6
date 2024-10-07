Return-Path: <linux-kernel+bounces-354130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE44A993823
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC941C214EF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A7F1DE895;
	Mon,  7 Oct 2024 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2xhk//Ek"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437E91D8E1F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332558; cv=none; b=JOSrPhcg4oS2WjmdwqgcRQlLXpDUSAH9Qa7YXyVmAvqT17ulJ0QMwVltwuMmkm15Yuw9jpcXgg0c8SPdbRiNFeK4Gdu6uiWVHf53oSNzXCpHMT23ITN8L1EH5gmOEa75RFvW6fAe7z5KOuIZwOhb9HXfw5z58EXKFzjkmCjCouE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332558; c=relaxed/simple;
	bh=21qP7Tak30Olxg5P/qZkkhpMiiPnYGWRaPxCeAM+y1o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qb/K3F9JNDJiORhhKvN4JLX3M1nQXzT5hj6fUrU0OMLoq7NDLG3HanyNYTle5gsdXNd/hxF3FplpwzPVb2Oe4RxhqlnSJlzUtQ3GZQv5njucKQQOmMEpP2qot8hDxxeanYXq1GLU2vTh8HsHmji70pDivGEGInBcHwKQRZ1Of2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2xhk//Ek; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82cf3286261so186425639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 13:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728332556; x=1728937356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR6hQb9CxfxGMdRoKEcbQoEJHNZRJy3CqaZVl8rk6E8=;
        b=2xhk//EkJy+lYoE40NfNiaY8JMyEv3g/Gm7BN5SKCdwDnEnVND0SwwDN80Inkkd/BB
         9DUdSJwxsRZOxlGywI7LfqwC5CljpXfhQQoxDR1JCS4AxeWQkV9p6pGpTB5Xe4LJDcaB
         zf7hl6CA8XruUUWmV23Y+ostTaWPAV9RVXvFGVdRTklyodT3YtEs8yhNsEv6KqP0vH9o
         Vzpg2Ha+wn1Tlbe7n6wh5qO9EhqiahsVE8JoC9ZN9lx2DvRyi5H6V+nataKQtzq8OncP
         n2j7yc5mma5nPhQ7ag/Xyz3Fj1EEBEBM8WBJFffMiNYFZYqVQSFtzJI3R0k71NSibZR1
         jEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728332556; x=1728937356;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CR6hQb9CxfxGMdRoKEcbQoEJHNZRJy3CqaZVl8rk6E8=;
        b=Bc8Si73+ZAiHmXI7nzsuyxXlCnf0SnNVtLjc7NgZpGHGwTqIJHKPNN/HYLILR+WERX
         AoQhZTYEGqKw9I8FJpNSWMfN2Azms8HSDrvXdINr3ABFzQVesdqZm7XJ04wWPjSquAQR
         a4RUrK98xh11GtwPg6nENhrH1EiZCHXSQl+ZEAFMjpYtaWVGs3OYyBVEtfxipBnneqFh
         Gbosbd6C7z4ToCuc2vLWv7mecuKHctoLJGhsnWmmWaklPClrnuVkS+oimwlR/By61Bjc
         NgvkH5s2FIZGl9bVKo1DDrNydu2TiADVGTzN85TCzgnCWC2bKXL+0uq4J2K/E6seu9rN
         rWNA==
X-Forwarded-Encrypted: i=1; AJvYcCUsr7z3Ony3nf6SmtCDGSELFO581XsGDtqHHJNou/DISXvC3OAyxe2c/M0V7XM8dn0riAFRaUKpg/740KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsjqKvYKNUQm16rJZ4RHo0s06pTcCWgHitrmhqXqHbQcBJ3GIk
	nxS9JBhEGNzXI52VY8v8l3qB86+gEeeIOEw4gj/0K9PFjXKrXnV6QEm80Ji4LfM=
X-Google-Smtp-Source: AGHT+IEAMVfOE5sPUtiSwm/TWfv2tfGIIhjiTnyU3vDHUtq0SM2wY34KGRRxJU7Br0YzNi0Fry8+GQ==
X-Received: by 2002:a05:6602:610f:b0:82a:2053:e715 with SMTP id ca18e2360f4ac-834f7d93c3amr1217728039f.14.1728332556273;
        Mon, 07 Oct 2024 13:22:36 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db86e86898sm605463173.61.2024.10.07.13.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:22:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Douglas Anderson <dianders@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Kyle Fortin <kyle.fortin@oracle.com>, 
 Douglas Anderson <dianders@google.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Christian Heusel <christian@heusel.eu>, Jan Kara <jack@suse.cz>, 
 Li Lingfeng <lilingfeng3@huawei.com>, Ming Lei <ming.lei@redhat.com>, 
 Riyan Dhiman <riyandhiman14@gmail.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konstantin Khlebnikov <koct9i@gmail.com>
In-Reply-To: <20241004171340.v2.1.I938c91d10e454e841fdf5d64499a8ae8514dc004@changeid>
References: <20241004171340.v2.1.I938c91d10e454e841fdf5d64499a8ae8514dc004@changeid>
Subject: Re: [PATCH v2] block: add partition uuid into uevent as "PARTUUID"
Message-Id: <172833255467.162249.3695820190422916095.b4-ty@kernel.dk>
Date: Mon, 07 Oct 2024 14:22:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 04 Oct 2024 17:13:43 -0700, Douglas Anderson wrote:
> Both most common formats have uuid in addition to partition name:
> GPT: standard uuid xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
> DOS: 4 byte disk signature and 1 byte partition xxxxxxxx-xx
> 
> Tools from util-linux use the same notation for them.
> 
> 
> [...]

Applied, thanks!

[1/1] block: add partition uuid into uevent as "PARTUUID"
      commit: 74f4a8dc0dd8bf337edacb693383911b856f61e3

Best regards,
-- 
Jens Axboe




