Return-Path: <linux-kernel+bounces-272629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DADC945F23
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29CC7284628
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08901E4855;
	Fri,  2 Aug 2024 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="hvvEoOcw"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1EE1EEF9
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722607794; cv=none; b=KfnOcs7fijHJDV36yBGyWDDNAwnpF+ul3yJhNULEExwuLlW0BWoxMtDODT6iuwrHIbBuk2RqI8WTMLXpnKa5M2w6SctXaP3GM+VHzzKfq3weabmRnEtVtN1oC35oT8i4GGHmMl+sVafbyS42AqCDhBcs5HwRFJAMOOGbJtCg5vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722607794; c=relaxed/simple;
	bh=jra6L/B4CTlR2NFq72iJu0OwzQ7WlwjqarLHxFb+pDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PadXNxrAU2s9d91jvcD8kdvg/V2T0pdOZSVN+Wz0wGTaP7nIYjbOtIee/2BgmZaxBeI3nePxuskO/LWL1FTKh3H9PYgR+Mmky4O6HM7KKtC7QENz8jR13oQ4wFkskRbddI+xVbKZnpav46d6zVoojg6f5TJQPFo22TmfYdAOc5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io; spf=pass smtp.mailfrom=foundries.io; dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b=hvvEoOcw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foundries.io
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc491f9b55so67066985ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1722607793; x=1723212593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onbQXwbvGRZtHxO8bwST8GBr/BQhg0G2IIchYZX1q78=;
        b=hvvEoOcwX/zdst73gFS59zfoB+WqikNASoQbHtrN+BZUbXurV8eiJNUWhCVa2nFvif
         cbDZ6uBXelwQEXEZOXmuQPceNZDnO52kbE7OeGnTVTreDZLaNyD/f0CRpSkvOmnVSifw
         lGFFzSdwAW1xSTJCtsbBkvk50gZs4B88CZxSO4iD8Qip1kfyk3zYMteTU9a4Ej+944rF
         ptQ5t2Nwki5F4glQo1p2/3Vs3YGneQO7YNJcDeO6ninUKdsRiSnqy4IXypk4TRh4U3LG
         gUMGxMuivNcEKMymQpIb0yWY+17P3qp7acEn9Bu96YfBkpP4yVd5IHlCKlMaR0X4ab8w
         NUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722607793; x=1723212593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onbQXwbvGRZtHxO8bwST8GBr/BQhg0G2IIchYZX1q78=;
        b=AUxyMwm5qXwSrI5L8ys+7tCypHS9zcIrMcqEQK4pN/CK030mSE8xjb4oJEKtjlEGGw
         EM+W3ETrcKlwb7YZT4S7eeV/0A1mDEfza6So+BaiIgNpNa75jLVWk9t2nVbmtK8JA4mL
         Nql3ZPFrcyX6UOt6yWIijoSw56F4VUDEaqcZn5oAG2a9acdWg6ZwjztE0Ho8uXm2SQxB
         5qTlZEPYqgqrmMyY+yEsfg7chEoRZ+zq1obu6FO/9wVkAzbFsrlT6TtxrUe2X/yEB3Ue
         Zh7Aj+nIb9MNSXv4C258LahZuT973FG+EjwlEWYcAs+BGyJKwJh3XwllPpf7xLqTdBPN
         I1Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWi1IDbGXFb2x/HrR+YDNZ5d8UHJlS8OGkG0wOlth4bpOB/twch1DSrBNeB6BaGAxOelW98AdeAOHqYikGhidp01liiTejJcsOnN07k
X-Gm-Message-State: AOJu0YxJUkC/LJxrp7b+5WgQLKRpc46Amji4Ly8aeCLsPWdAlk9vRsOr
	/mXKhTck+MIJhw2fGaU/3n9qPv1Q1OTz9+zJW4CdmgAQhXhjCIPh+DucHb56xYU=
X-Google-Smtp-Source: AGHT+IEJePKCgDb4w8BqZv94T5BRKWH09KZwYwkz4+WJxDFtkiMmhdjqhfnHlzdRaLq/4m/TiEmvjQ==
X-Received: by 2002:a17:902:d505:b0:1ff:49a0:46b1 with SMTP id d9443c01a7336-1ff5722e7abmr49769725ad.6.1722607792834;
        Fri, 02 Aug 2024 07:09:52 -0700 (PDT)
Received: from lola.lan ([2804:14c:3beb:8e:e577:62c5:62db:a016])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f6093fsm17638875ad.114.2024.08.02.07.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 07:09:52 -0700 (PDT)
From: Daiane Angolini <daiane.angolini@foundries.io>
To: max.oss.09@gmail.com
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	max.krummenacher@toradex.com,
	stable@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	Daiane Angolini <daiane.angolini@foundries.io>
Subject: [PATCH] tty: vt: conmakehash: cope with abs_srctree no longer in env
Date: Fri,  2 Aug 2024 11:09:40 -0300
Message-Id: <20240802140940.68961-1-daiane.angolini@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725132056.9151-1-max.oss.09@gmail.com>
References: <20240725132056.9151-1-max.oss.09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> conmakehash uses getenv("abs_srctree") from the environment to strip
> the absolute path from the generated sources.
> However since commit e2bad142bb3d ("kbuild: unexport abs_srctree and
> abs_objtree") this environment variable no longer gets set.
> Instead use basename() to indicate the used file in a comment of the
> generated source file.
> 
> Fixes: 3bd85c6c97b2 ("tty: vt: conmakehash: Don't mention the full path of the input in output")
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Tested-by: Daiane Angolini <daiane.angolini@foundries.io>


