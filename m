Return-Path: <linux-kernel+bounces-323621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8028B974071
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B08288CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E5B1A4B9C;
	Tue, 10 Sep 2024 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cAhgTkSj"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBDA1AC447
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989565; cv=none; b=RnVifdJ/qPjTbsglDXIow7NEf4BN9R5Vr6QVQ4dyJQr9qXAfvFIB4pUeShf6qbtqSWFaVFoThu8VGVlo2TKT4qpvwBNYir5dC1ABKFph1bKhVEz+nlCVcHL0on9+SZT9Q8jQyp3b65ATcTaJGe8cekWklbd8puzcUehYyhdtJIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989565; c=relaxed/simple;
	bh=+OQCKGjOreNPFlCZg+NpojIK/AAqvIGpCbTctLN41Zg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t9KMQ+UmN0Ltv9ZEmNhJfdvbT3xQKuIXBND4bmBzBhutBjc3Ktq3btDjngSnGRqUUfLh+L9KZt7obd6OmBLqJCWIQRzraQ4conMfhRpX1WorV8dZv44eghdKYLMpB/kr35gkBTa8SNlGK2VGH0iab1VWVIsf+V3mH5BSMImmqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=cAhgTkSj; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5becfd14353so5520434a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1725989560; x=1726594360; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+OQCKGjOreNPFlCZg+NpojIK/AAqvIGpCbTctLN41Zg=;
        b=cAhgTkSjTriCP5c1OIndbZi7f4qNqqcoK0jFreASZoAeZLwUynL1laLSiR4OpsGZmd
         PjiPATe4hYxEb3eEGeDcbewiSvt3Fafh/bowhSfOOLpC2/zQyOiHsuZvv3vv33jNWoWB
         9IofsugZGUjNbd/+vBlXDCTkHYgWtyAVaFNzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725989560; x=1726594360;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OQCKGjOreNPFlCZg+NpojIK/AAqvIGpCbTctLN41Zg=;
        b=UX1RRVf9F+cIbkJ3dGZXt4UXxxLZCvD24tQ9A3jrakqLdohjHtVmV13epaeRUf5shl
         sZIDqog2/VO8ph5a3owdQdDOUI0hNQMNEMokSGcE6NtnjB8tSZm+9adHFEM/pxM0l6Qp
         v4g7QZ4Sl66+avgtK05gM33rWGEZfzymlVF+qt4fqu3RuipKb4nbZaUt+uZ7m0s6wNi7
         r0/voviY7K0iNa/SkuCClBjbnj22zsmGv3f2iMO3SkkAT6bL1IJ2d+t4P+PyvzPtr6p0
         JEE2Mg86fkhYyjt3JGnz6EAQVL3mwnii4UMkxRNznNh2eERfi7j+wu9Z+Ez9V7WG+Yx8
         +8nw==
X-Forwarded-Encrypted: i=1; AJvYcCXmUQiVF9VmeIsoxer+N+xLZdhW2VptanE7PwmQEPfBLdsaccyk/Ns9Bt/xEG5oF4XogjayjoRBpNDu4rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVmbSxzvqEQW2AgKG0I8JUyETPy0R87WYIHG3aCgFbBcV9M0bt
	bK38tcdL1sesUjOu90Kb6E10hqiyzlRBCTepcFKUI0Epyy2anaOoTRpT/xbN4Kk=
X-Google-Smtp-Source: AGHT+IFfyjBY/uzGM6saZRblrDwQ8lp+ygNcmBWjQ5jvHL2+iO/HSsVfBt74/1cYQ1N5XfuDXvGFrQ==
X-Received: by 2002:a05:6402:50c7:b0:5c3:cc6d:19df with SMTP id 4fb4d7f45d1cf-5c3eac20c84mr9233359a12.28.1725989559644;
        Tue, 10 Sep 2024 10:32:39 -0700 (PDT)
Received: from localhost (77.33.185.121.dhcp.fibianet.dk. [77.33.185.121])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd467desm4436849a12.40.2024.09.10.10.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 10:32:39 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Esben Haabendal <esben@geanix.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,  Rasmus Villemoes
 <linux@rasmusvillemoes.dk>,  linux-rtc@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rtc: isl12022: Prepare for extending rtc device
 drvdata
In-Reply-To: <20240910-rtc-isl12022-alarm-irq-v1-1-d875cedc997f@geanix.com>
	(Esben Haabendal's message of "Tue, 10 Sep 2024 12:27:10 +0200")
References: <20240910-rtc-isl12022-alarm-irq-v1-0-d875cedc997f@geanix.com>
	<20240910-rtc-isl12022-alarm-irq-v1-1-d875cedc997f@geanix.com>
Date: Tue, 10 Sep 2024 19:32:41 +0200
Message-ID: <87a5gfifd2.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Esben Haabendal <esben@geanix.com> writes:

> Add a struct to hold the regmap pointer, so more information can be
> added.

Heh, this is morally a revert of f525b210e9d4.

Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

