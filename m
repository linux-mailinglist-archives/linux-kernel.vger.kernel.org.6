Return-Path: <linux-kernel+bounces-438433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6F49EA149
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33E2162F94
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEEF19CC11;
	Mon,  9 Dec 2024 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCV0Lpv6"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907446B8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733780166; cv=none; b=L/+WtYVdVHj4vf9tBoTKGRKTOj9US1HVTomZ7LIAROphMywKOGKRp68fOXjWyS/Pd/C7LRvyj80Lw4NNSszj3ltjHJ7LbIxYZFKgKBXLxBomSxE+4WKMm5ncniOw0Y4u2gjlDQWNldqBOvpUNCjCa/XIDAIzHfT2Cgo91aSh9LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733780166; c=relaxed/simple;
	bh=D0GwfPYzY3d075kroJefVRvpK4Ym45rskIgN5d2eWRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8IEpfzD1sIm2eGXge7pKzL8EW/qtlyg3sZvjVQEp78ccCyf2HyYdddeuPPQ8J/ujpcivcE6tf8gBp28qXRATcuCfbhvvWeVndNvZLwLh1J09ZlUUHGidjbQDtVhlo4rtwjTk+GDu/jO3tT1DDh5+/LE7SQmJeXaCCH8590DIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCV0Lpv6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21661be2c2dso8856025ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 13:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733780164; x=1734384964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pMt4qFSFzCxvYGSp6kfDCRph+Y7dx/tSTao0y9+V/Q=;
        b=JCV0Lpv6EJoeeGjGwZEQ7PqnbGZifgJtwV51eFMPcGDbMcp/RsazH4qFRAlvrbzwBD
         E7W9bsSWWS9wfQTIFVeUO0+HOubNcnaJ31MxVTQOwN2Qjhg7dJiQQCyNm5s2KrIeN65N
         QrtTBe4xZ+olUEuvpOd3jmjijVOPRUG+KiLsTpLPA/GfinPEYCKAao1fbZiwcEz76dXw
         s072Nt7RRKI4D2H6P25RinUgFjCPQ1O+IKkvH+P5YMp7tGtI2ZD2WRDDYNB56ems4W9O
         B7O8zJPz6uSjN6g1/Tm/p3zAJ0HAlHqRJbaj6qIyI8PwhUXVxxjML6McX5uVOa0S0sQZ
         zvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733780164; x=1734384964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pMt4qFSFzCxvYGSp6kfDCRph+Y7dx/tSTao0y9+V/Q=;
        b=VChDnR13kqruwRuoYnjpNzeuAP5Cl6G+90HeAA9Q1RGNSnZEDDKMhKbifLca/pk3lC
         vcbbB7JhwPGkKdgJikB0p4LfpUolggOVvm1BUZ4sYAChvFvJX6090gg5ifI8qfgblvHi
         15E3IYuSBn7PU1jef7qgMLrve4fsWhrmzUaUzyMT1HoJquKSmAe47splzowZDBSpYCWB
         UwvdRlB/BuBJPQKdPBvTx1XSC5qwKpZqa2mTKqM5j64WMFyf1C6bVehpUH2RNDZKVcw8
         V/H59Ad8J+VnEfw63vB0e6EcqLPhxGN9yBzv7jtPDTMiwb5rhHQi4YZenxW2AFavIkCq
         +KrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsgXx23wOjxtkIcoAGnTx+SS79an4W4rN5KqbWXEJ3Cz+HWKWbfbCSfVzT3t5JW1ZLtAi9wRNn780+EdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnk947ylj85RJFmwnHAAZWvmAWLOWgJm7LpyTGuJSqa8rZw7Q8
	j/HOTfYONOug+CykVXIUNv6AgD6FO/V2gtV+ThUJ8FRCLcaBEjQQ
X-Gm-Gg: ASbGncuWS6pmHiD/uEbkqDQ7t9vSsWHG/sVLscKpjtvfxgbIobcSHlsA5GkhdCNCOGq
	JKSfEO3bFRBG/x4Iw5e2q/4y8cP2ivfUydhjpGGdFMuMSvIfos+FJTMiPiSy1WrNvdWEhFclg4F
	NqTAN+4XEnWY1VsJohDhUCHha3lfdcC/3DcxDDxhX/cwl9ukp5EbBFygj5zBcIqxeC5pU2lC0kZ
	/Nk+GMW2NMieqhA77J7OgRH+HXxlFndH56G1GYkYd3P9+VQd4Lwn+Czvhq466nUIG+Kh5XGbq/s
	Lg==
X-Google-Smtp-Source: AGHT+IGsrljXaZKtJMEfPwNsl5nnfyFklzAzvDNzZO2kCxojOA6DcgslKTWJXpL0hci5T4lQb5O0jQ==
X-Received: by 2002:a17:903:1ca:b0:215:6489:cfb8 with SMTP id d9443c01a7336-21669fd0edamr33805595ad.10.1733780164144;
        Mon, 09 Dec 2024 13:36:04 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216634dd69esm14523955ad.40.2024.12.09.13.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 13:36:03 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: dan.carpenter@linaro.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	philipp.g.hortmann@gmail.com,
	rodrigo.gobbi.7@gmail.com,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v3] staging: rtl8723bs: remove code depending on cflag
Date: Mon,  9 Dec 2024 18:33:36 -0300
Message-ID: <20241209213528.5917-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <42d24db0-b403-4c4b-8607-38f3cd55cf63@stanley.mountain>
References: <42d24db0-b403-4c4b-8607-38f3cd55cf63@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The commit message should answer any kind of reasonable questions
> a review is probably going to ask but it doesn't give any information on
> this.

I'll try to improve this for future patches, tks for pointing that out.

> This commit would easier to review if it were broken up in a different
> way.

Ok, in that way, a patch series is the best approach here, right? 
Despite the changes in the series being dependent on each other in this case.
Tks and regards.

