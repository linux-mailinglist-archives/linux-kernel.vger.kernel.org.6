Return-Path: <linux-kernel+bounces-273048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C58A9463FE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25201C209BF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDFC1ABEAF;
	Fri,  2 Aug 2024 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lfvmRb15"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F23481DB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722627462; cv=none; b=hq4uyk6qNZi7j9BeBco4seWpvHsjAJVv4UtxpxWCtU46xEW4y3CLubdFLlIjw9YiT+n3bF1Ul7kFp3WGag93Ss80/UqoNkJEGcZwxXVMVaemZsAvXspf5caYThfQuUTpeCCbhjqpU2plP4CKYBsxz3rKZXALR7SddphPG2e380A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722627462; c=relaxed/simple;
	bh=CV4GXsYsfgo4q6hKJxBuFlLUCtWcIZ6hQ16Fz+Sbo4k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kTAFj/aGIUOIkAELOAhfwL04HWjOy9Pt/JNMLL3c0E9awVZrzSSbRb+odPZn9Xjt/TsMaDEmg8POPJ+BxEKxbA4p9ScN0W3CzSKQWJ2DcLYWRr/TBpQmu4i4sFjGBHINFVGUFUP98E4ZZYuSSI2AfJzISyWpop5C8Iby5/nCOKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lfvmRb15; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-398041b6e3dso3067085ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 12:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722627460; x=1723232260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aq0OPmiAfzDwBhbEkdc5d+5HiIl+Llio3iq8YdlnX14=;
        b=lfvmRb15Yoch4WtjVBrNK2iXfM/nrtA568MImD+etDI3CSkQvjs0LEkggzbO1Z+veN
         WGyBRtZY0Jc1b0YC84MA1mPkdkb5K+HUdacqq1KY1mpp4I0DJ1RTyli1fw5aV9mPYjUn
         zcCMNS6WYhavncVEjkip6hwGopM3BbSAUDj+/AfdJ7Sh4X3xcZuo1evye3AqKpC4/0pY
         Xs0E713zp+8Wvn92Tm6jElT+EnbNXkEwcfOiYLY3uAOUcZS08HWj7snG4UXceELnle1Y
         e6lsCIGN59pJEOJE01U4mZy7WmCVUnhyugl15FA+UvfHkZLW/MbLEL7CaBrwp1c+72nk
         R2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722627460; x=1723232260;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aq0OPmiAfzDwBhbEkdc5d+5HiIl+Llio3iq8YdlnX14=;
        b=grQewl9TvVIBfKisAiwRPlueKy2I6XrgNDRJs3CE6z4NlNHsNoeq+gFrFdwaTVjYpS
         NQsIQ+PBfkbgCGr73AtG119TYkxnywDgYauDtp0E8At/q0r8yDJ4Oxcys0RgFB0eT0NX
         u/UX+bnIhWWMZMb3HFV8PNBsDqDGc54JV7omRT/NrKqfM5CWJTyF9L55Yh2xTUub1kym
         Zg52I0+9uvO+Zk1ysBXXqfYYfXslnTGLzRu0aSclZssbCXgAYuCp6BWZ50/hFxzk51ft
         BV+3Jqgk4zip6j/6GXzgpXBV04pACE4Iucp/627y+2hgjnc6dYz+7XZo1wfb71Tx5GmV
         PHig==
X-Forwarded-Encrypted: i=1; AJvYcCWiEXp+/IcTglpxmZfBHLG4E2kwvlcmZcsSnUrG43BfvewEfSqYMNEck+LkV0de2e4LdEBjK3w3wtg4mBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6r2e3mbak8X6re/tUE8wyFSUAUIap1xTCEKM0TndsbfeYuq3U
	k0qXO7JnrdvOtTSFTY0fTUr2/TgTnjHQqJB1OIJGDtb6QfTJTOI0aCy15qmNuAI=
X-Google-Smtp-Source: AGHT+IF38B2WBsg1Z9PGLO03sa2FOioYxYdCZ030WghdBOYn5rYnHGGG2VBaYVKz14EzsjdIgN7zTA==
X-Received: by 2002:a05:6e02:1c21:b0:383:297a:bdfb with SMTP id e9e14a558f8ab-39b1fb736eemr34987515ab.2.1722627460233;
        Fri, 02 Aug 2024 12:37:40 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b209d833esm9710825ab.0.2024.08.02.12.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:37:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
 christoph.boehmwalder@linbit.com, brauner@kernel.org, 
 Yue Haibing <yuehaibing@huawei.com>
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802095147.2788218-1-yuehaibing@huawei.com>
References: <20240802095147.2788218-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] drbd: Remove unused extern declarations
Message-Id: <172262745942.170878.5478919565358638351.b4-ty@kernel.dk>
Date: Fri, 02 Aug 2024 13:37:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 02 Aug 2024 17:51:47 +0800, Yue Haibing wrote:
> Commit b411b3637fa7 ("The DRBD driver") declared but never implemented
> drbd_read_remote(), is_valid_ar_handle() and drbd_set_recv_tcq().
> And commit 668700b40a7c ("drbd: Create a dedicated workqueue for sending acks on the control connection")
> never implemented drbd_send_ping_wf().
> 
> Commit 2451fc3b2bd3 ("drbd: Removed the BIO_RW_BARRIER support form the receiver/epoch code")
> leave w_e_reissue() declaration unused.
> 
> [...]

Applied, thanks!

[1/1] drbd: Remove unused extern declarations
      commit: f48ada402d2f1e46fa241bcc6725bdde70725e15

Best regards,
-- 
Jens Axboe




