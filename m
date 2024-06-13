Return-Path: <linux-kernel+bounces-213646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5615F90784A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D20283285
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A5B1448DA;
	Thu, 13 Jun 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHFU+Us8"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2997C130AFF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296228; cv=none; b=ZfwLCFiTLEEpiyGhxwCgzdmMRU08BKhDf+joJ8T5IhyQ+s+BCN1x3lrSjpxTrWHFeMBgqMbi7ij2Z2lyPx9GxueJsTDaaZ57U7dBPFMbiDwTCFWYbadBrY6JLBxBV9TiByYTQxdYUSXONE1WUimC96ucK+1QDNYk/4hCbINWr3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296228; c=relaxed/simple;
	bh=ljLIwAKIaCu2K87aK/wh1nbzUGaK0MbJvtQTnuTlktI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HSPWBCHgEFFH3lKQXNhB1CGJa1isHAEW8e7GMEX0WYX0QDg+OCe+C/0C+ySVbORG2y/T2cIFK3/fgnYztVcgEwDyb3evtX50mIkumSz+pHfuCWY/9mtVWjdylSycEGmjMc8C7Dqbi+qJ31FPom9o4j0e4ZTqQydaQJ4Yq41JWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHFU+Us8; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c327a0d4c9so1760950a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718296222; x=1718901022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljLIwAKIaCu2K87aK/wh1nbzUGaK0MbJvtQTnuTlktI=;
        b=fHFU+Us8bh9/AZivtskM9j9zW8RXaF3jXhKlB8a8ZE1hOHGfLb8He0BUBCeKxYk6mR
         ItC6EjnSGx8FstH9pXvRJnfbxHPLXVcD0U1+57XJ+CqQbauhvYk6Pckj1h2RHh04S0zJ
         OQ7GTNIitu3lbsPMBLfZx/9SOmE6rRuftWhSWyAkRx5aezSO6lVP3uhDhMRGPJLG2EyV
         qugXEbflHK/+G2lXdno6nMHaj0Z0pG4qeUfMt5AsxO8SoE1gxNdmaTkT6i0/b7AzxZ8T
         b/icyTWiypm/fDtTF5V7JAAs4GJunOs+/PuDDRp9H1wy7onKPgig2SW8TyqVmm1PHZVs
         3fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718296222; x=1718901022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljLIwAKIaCu2K87aK/wh1nbzUGaK0MbJvtQTnuTlktI=;
        b=Yk+nsdaODGNZFUM4HhyBp5h64bOMF7DpTcnqkwTPqVYYfDQprPuxGOzGGO5vRbgaVU
         Bb1iN14LgGJ9Qax7Ctq8ejRBm85N7OJmBbz+Y8QJbrgEiTmYGw3fYNoxkg5s95DBSq+i
         TAGwjdADNrSuAhVIvjcIFDWUz6koGOxGvZxPGUDVaR95Fr72qtpeVV8SM0ueb7hvA/6S
         gHpOj1QQg3riu97hW0Nt+gNT4ekbeP83S2QPlqcslfVn5xgTbDABSeXmohw9G/iJ+MIg
         /KaKNzSBf5iMJfo9wE0MRYc4ouUD8lfXJP7fI9Ugo+OawGTNS3X+uwxlE74babn20D0s
         I1HA==
X-Forwarded-Encrypted: i=1; AJvYcCXRcWoWrIiLMGxb7N+ugv8lrJudAz4yTDdDwGTxoRHoRqNtlsh+lXEL0lxpxU/B6Af7v1mnDptUIDkIGhyF//v7eWAm7ZD/9BXhNURV
X-Gm-Message-State: AOJu0Yzj2tLwt8JLBVCACnz5pglpBrmRCAvwp37OGGYdEH7RXNnvbuxW
	HolCkbufYMBEcGtq7aYVJlwn+RHqgaeRTYz892rSmg13lhXIn3RU
X-Google-Smtp-Source: AGHT+IFec+p7vxH6T9f20tm7W+m1gJvHG0TWdSGyf00ZquKyJJVQRoo/2HjfwLn4STVbqpXz24gxpA==
X-Received: by 2002:a17:90b:108:b0:2c4:c2a9:3171 with SMTP id 98e67ed59e1d1-2c4c2a93b29mr4016667a91.5.1718296222369;
        Thu, 13 Jun 2024 09:30:22 -0700 (PDT)
Received: from dev0.. ([49.43.162.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45f8690sm1931868a91.33.2024.06.13.09.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 09:30:21 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: bmarzins@redhat.com
Cc: agk@redhat.com,
	dm-devel@lists.linux.dev,
	jain.abhinav177@gmail.com,
	javier.carrasco.cruz@gmail.com,
	linux-kernel@vger.kernel.org,
	mpatocka@redhat.com,
	skhan@linuxfoundation.org,
	snitzer@kernel.org
Subject: Re: [PATCH] dm: Add support for escaped characters in str_field_delimit()
Date: Thu, 13 Jun 2024 16:30:15 +0000
Message-Id: <20240613163015.38097-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Zmc3vrfFglYISw1P@redhat.com>
References: <Zmc3vrfFglYISw1P@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 10, 2024 at 01:11:40PM -0400, Benjamin Marzinski wrote:
> This doesn't do anything to the escape character. Presumably you want to
> pass the field containing a separator down to dm_eary_create(). But you
> don't want to pass the escape character itself.
>
> To work correctly, this code needs to remove all those escape characters
> that come before separators. It probably needs to do something like:
>
> 1. Find a next non-escaped separator and change it to NULL, so you have
> your field string.
>
> 2. Find all the escaped separators in the field string, and shift the
> rest of the string over to overwrite the escape character with the rest
> of the string.
>
> -Ben

Hi Ben,

I realised I should have done better testing after processing your feedback.
I have accordingly modified the code and shared a v2:
https://lore.kernel.org/all/20240613162632.38065-1-jain.abhinav177@gmail.com/

Please help review and provide feedback again. Thanks.

