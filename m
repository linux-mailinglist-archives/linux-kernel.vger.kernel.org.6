Return-Path: <linux-kernel+bounces-290222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841C69550E5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4761F2168F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683DD1C378C;
	Fri, 16 Aug 2024 18:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wq6dWmvT"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FFD1C3F1D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723833106; cv=none; b=G5/xqPx4Nde2IHcz/jV8ZUoMGatvVQSY99P4BHWJDJaE1sDDC84FplqaUbifnHEcs9meybsnBudhKesagiLodlURieb1NHpPM5Kba1E574Obmb2Um9s/lsfkiwqwXFTJ/bivySEQx/WcMF0dp3o+Aanbh8dj5LM06Hnj1rpDAoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723833106; c=relaxed/simple;
	bh=wBLC1xx411MuYumWmylECOlPJ0WUNHKgh5uSMFv+/Ms=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SYO4LcdoqOLz3cH59XfL3M0YR90QCkCgbiLd/rpDBmMg3NS3HJ5BROz2+L/cKGCbsyxZmlQS83ib+pbn4Zb9QkK3ua9Aq99EeE8TnrjSvlJY8BRdyS54Tc/f2OOUzOM/nIgnSvUVV3K/Sk1AUzhBia+UYGox5p46soX7Cd569ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wq6dWmvT; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-81f932ede28so8936139f.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723833102; x=1724437902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyWPYhOxF7kF1eQQpUEIw+fTUDykck1g2NssSbBG/20=;
        b=wq6dWmvTiV8EqsbeJn17e46dmg4bbzRzqqFhfnrYTCznUhf7Wu4LoQn24GI1/XX6lL
         jF39GHZbBhDRL6eoXRYra97tIVDDBntKpBlC0gBBrG/IngKJuY8WTj/gPmMUK6lrsAhh
         yzZuM2e8aNAh5/HHl1k0w+0vxYst+kk/VIHVkFSN04utQ+IAJaEYDpXaziWEN5G1Im98
         MLCnhUDumStnMdtnuoel37z1hjaGEG9S3OND/3j//wOz2GIKumqZD0w2nW0e/IquR9Nw
         wNShe6LB7UPlUb18MRM8xZAkg21YR0MM9vya3yogkeZts5VTf6B78tgr6Zu7YDP7qtwp
         0XTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723833102; x=1724437902;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyWPYhOxF7kF1eQQpUEIw+fTUDykck1g2NssSbBG/20=;
        b=CVvNNvk1dTgmb+4+Qkh9jZugf05W1sEHciGTRCEXVB6lroT0vP2WAf8a5Js64nUccs
         0qQUOeTrbtO8+jV8qZOQBggegFs0nPaLTEEpPXoeqCPMPNbUdbbpp6pRwEr2wFXRGAA1
         v4OMjefp2lVVimWiNxTCy4nMZwd2WYde2i1tYYmdBBlA+ouAq+PWsYXA8ek8yos07N/1
         w8Hc4Hplz2b6CWryghkkplLlBxf2IbO5aRESAPWA/UKYzaCB/f4g+tzrA+lJQ964lgLL
         Crmygz5OY2uo2cXwxDCpCu0A8RVSPhbt1UZkHycOIwQy35AXgoY188yyB7D55MdZzKA7
         Hwmw==
X-Forwarded-Encrypted: i=1; AJvYcCVC73PN2Ne3hwIiXEzX98s7sbTFXmr++DeHKr1U92StZaE5NmyHhZHdDpTYEU6tXbzw4mciBqwZySP03KU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyct2Y1cAUkhmbkvdzVruWFICZbnf/JYBGeOm1vNbSsHAcPeqc
	Z/inypGDisjORMe5tte7HFXf6SUL+0nrxyCB8ulPCY8CKaPjiwN5IU4qbXLdhOk=
X-Google-Smtp-Source: AGHT+IGQSXeaw/DqDeJx2+noxycL9i553HwUohD6ABSHKf1OrHgQxNiEftc7fIzHcS749UNlUk55Qg==
X-Received: by 2002:a5d:9299:0:b0:81f:9219:4494 with SMTP id ca18e2360f4ac-824f26a6827mr273898539f.2.1723833102399;
        Fri, 16 Aug 2024 11:31:42 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6f3dc96sm1387426173.115.2024.08.16.11.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 11:31:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240816181526.3642732-1-csander@purestorage.com>
References: <20240816181526.3642732-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring: fix user_data field name in comment
Message-Id: <172383310135.58661.17925473453197931956.b4-ty@kernel.dk>
Date: Fri, 16 Aug 2024 12:31:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 16 Aug 2024 12:15:23 -0600, Caleb Sander Mateos wrote:
> io_uring_cqe's user_data field refers to `sqe->data`, but io_uring_sqe
> does not have a data field. Fix the comment to say `sqe->user_data`.
> 
> 

Applied, thanks!

[1/1] io_uring: fix user_data field name in comment
      commit: 1fc2ac428ef7d2ab9e8e19efe7ec3e58aea51bf3

Best regards,
-- 
Jens Axboe




