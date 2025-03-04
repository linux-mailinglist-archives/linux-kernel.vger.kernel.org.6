Return-Path: <linux-kernel+bounces-544376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C0FA4E08A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C758616C694
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32AD205E16;
	Tue,  4 Mar 2025 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZBQoLGja"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5053205E05
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097794; cv=none; b=GU+7WhdJz5vqnrPXkThxIbd0V4EM/eKnRG4mTTCNul4rlHuYO/lm/PODfADVVdwxHlodgdtYemtTZmY9ygZWIygygm5ExZdmYfZRlKPM+gwws0IZTMy1ztkjZPzRsmtpGLz80zzdDI3wA4UOTGZ04TJ1f0LAcFlo+8hmKr6HQUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097794; c=relaxed/simple;
	bh=ChsJ9RkdUo1r4X4TzdGs7HyBdF3iA2cg5kze8FQH5K0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XM4Gy4Cc7KQjRMknccPgkBQjuChR2xeOcYnvqeOckHeED4C+AN8k8l4yvL2e2vPzVF5kWgGVav0FA8p8QhNhrbo6vdzIoFLROTfSgGaBtOP78LsyPdrhwM28iedCJZuEUTVhwOXfJtb/tgtqkPj8vBwphFz2poz6H4Y3aojYWEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZBQoLGja; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d1a428471fso45820805ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 06:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741097791; x=1741702591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FM9PNtJtl+yhxDbsm1TCZkNlDxu9xhRfz1Gk9BMDczc=;
        b=ZBQoLGjaCCbY/b8tIF+IAd7okgYX4C842+3XTiye1rnt1eYeKWiv2abGwOi5TFXE60
         SxSSko1K2zq7cyKJa3YEWlsOchoqqzPj/r8QgyWZemzUpdC8aDXZmqFLOOmbqqcRBLB+
         w3WIxdv6ELn9rhONXpQ10bjtVrmu13KsdRxfWZHZAMoWpxZ2xdHf/wTmIgCVO7mwSfKB
         H/PiYwKsdeFzTGV2tJe8l6ByDnkoWHuTDX2rHbEAFWuseFO+MeNbIhOGzoSbBxoC1Z/u
         buOd/jp+QH3oFP0CU6chA9qDiRTND7E63wkvCReAHivr2qyhbYv2ZcnHw3V3vZRGq4Bh
         sTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741097791; x=1741702591;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FM9PNtJtl+yhxDbsm1TCZkNlDxu9xhRfz1Gk9BMDczc=;
        b=OH2nCYUzaIA29erc/S2noVuSuSaUoDBDaXzLQFMuu+dVM7vYeV/WCtvw+Nk9Y5CqQm
         /3o2pIffifoUCiRQ+H4mrd8J0kA9DAybNxL3eQnrefvbjdNuupCOXh1Fge7Eu7ZjKM6f
         HMGqMKDY0cNMv38iJIAxuCgl005bZUg2Uu6FdT6EjGjSuPS1wSQBg3yTDaVCkcy3h38E
         C35enJeEVEjXyRBv1u7NmnKPW+9GLheBKY+xJVKNf7BnWIww7dKB5XdAijEyS7NnGwj8
         lOb7jlPi9/5BKIKXl3fZ5ek8hf9RZ95OGQiziKbnUg+ZdzW98SPpcZe6/tF2iBdrNBvm
         JAXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm3B7GF/tUybOwxWJPZEZzJsCV7WiigTxex4KwaQja3PikXv994qd0+RzzhI9AeajGpquxqJcmx+wxYnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNhIGYKtAkM8kXX98vbfICh5zvCws2otALdF8ab4qGexf02r9P
	kPmGZv3Kc6ZSGaDQ4vGbG0IWWNqQoL8sVDqEvYJ3iScKoD/ODlAEDTK/1f3xseOIvNV8xkAlI7u
	G
X-Gm-Gg: ASbGncsBKRidt1A6uo+AKyx6sy9mW5Y/csRDSwnuNywvyWlxZWOifhgx1MB/CQR3YC7
	lLsUpUW46Vs/PcHDS21Z7rMoJbjdnV7xQ0dRNe037QOKcS1LWFdbBDw1wQ9NUHQlr6qaWZ2a8YP
	lOlIgkbhm1eBdzdkUPYAwDRsPDxsgFw+dlm1ZDE5zUyUsK/lY9VqtPYTNGjWsHNJUY70IrRrnd6
	Nxd5jKoj9Pnhe1d4auNEoXNlY8939D5EMQyRdczHz9w6NnqtE8VbaWeWWzx9vK+fICCMayzVtKZ
	1ZNQYVIqZRu7ux2R47EOpDZIuz7hr5sQTho=
X-Google-Smtp-Source: AGHT+IGF6Zx/rW9mbboTwPHs+JlfjpBg7k/g4yU42/7VmU1fGZrFcCHsi7kIQRTB9DGXWegWS9TfqQ==
X-Received: by 2002:a92:cdab:0:b0:3d0:237e:c29c with SMTP id e9e14a558f8ab-3d3e6e90e50mr189150955ab.12.1741097789907;
        Tue, 04 Mar 2025 06:16:29 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f1e668e5ddsm712422173.140.2025.03.04.06.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:16:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250301183612.937529-1-csander@purestorage.com>
References: <20250301183612.937529-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring/rsrc: include io_uring_types.h in rsrc.h
Message-Id: <174109778890.2730103.14634886908772666972.b4-ty@kernel.dk>
Date: Tue, 04 Mar 2025 07:16:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Sat, 01 Mar 2025 11:36:11 -0700, Caleb Sander Mateos wrote:
> io_uring/rsrc.h uses several types from include/linux/io_uring_types.h.
> Include io_uring_types.h explicitly in rsrc.h to avoid depending on
> users of rsrc.h including io_uring_types.h first.
> 
> 

Applied, thanks!

[1/1] io_uring/rsrc: include io_uring_types.h in rsrc.h
      commit: a1967280a1e5fb2c331f23d162b3672d64ba2549

Best regards,
-- 
Jens Axboe




