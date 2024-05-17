Return-Path: <linux-kernel+bounces-181739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D768C8080
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 06:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8054C2825E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 04:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA94101DA;
	Fri, 17 May 2024 04:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIYzXmak"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7912CDDB2;
	Fri, 17 May 2024 04:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715921933; cv=none; b=hpYkULM7zHqDA7gJvn60u0iLmhkEsKyKrPll9XSwedoOshPxQUdYAHY6RYTXbXQDrdwulkgx6pP5tL6AzUJvM71kRZ+8GmRaEwJehH+mm4Mh3v+QCZfvmE0wL7jRTwoUOMu1+sZ5E+MYJETF+6H7rwoPp/HAiq9DAeYUFvQs9+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715921933; c=relaxed/simple;
	bh=zD4lWmp3wEmNB1u//FuurUIsViWz6cyW2T5QY6kRnaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PmVufR549XIJnMQ9U6EBrJZfv9p+PT+qILVONg+zO1b7c4pIxh9ve2IV2UUSWvr7/s1a7oGQVAdtbzC82dMTZb2+OXbrBK0jt0yjTSjXubbS2F7odu2RmzGPxDEO+jVPmsdqUvSjVcVFk3CVtD+3OWEtNPS0v4tTIwuK4mnpCP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIYzXmak; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f4178aec15so921816b3a.0;
        Thu, 16 May 2024 21:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715921932; x=1716526732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zD4lWmp3wEmNB1u//FuurUIsViWz6cyW2T5QY6kRnaY=;
        b=bIYzXmak1ZTOeqNggHit5mWiX6p16HIa3P/9/UsfmXSAweVo7bXNWAMk6O09se8ywl
         aA/jiDZTJHMywUQyJ46mLQCzjf7lm1UK5nPEAIN5iiwAeBF3Y7gQo/L9GgH+MCX6JPHE
         xymcOzuYkQfECtYsonWzSmB2IjtG/3QFMCSjL806Qw20P71nUXjcQzh2shrUH4XGJ+Qm
         GzjdUmIyAalBfUp4I2iOOkTLSkw0v1skj0IMQRAvdkl//XGatYQdgozh0VjseByRBvnh
         djgLS81VRkp8qA+BRB5TJZjU0iujk2pkPrPZviPE3F8YyWsQ+bJNdejbTFknHvaV8dD/
         k88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715921932; x=1716526732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zD4lWmp3wEmNB1u//FuurUIsViWz6cyW2T5QY6kRnaY=;
        b=c0YM/gtl4gBxRyyf+FD+vqg7eCHLL05bT/A10FusRlHM/238s4WQ3akd0azjhNgvfc
         i2RrG1f4Zn3/PqhE+ISu6T7BeeDZIkKkR6p39wWzAROmQnU5XbmnxEE7vvYEkJEOUnEO
         28137lIGWCvK9sPcQOk1P8f2vw+5Mr/TXqxz8ARlRbQvDD2+Z4jybt3FFQtIO0vpM53V
         Oyx8NfaF90EBoUhgcFdgNOTfA/3c5UtUmpcoHmuXLit6T92W1llHoD5t8KQvTThNYGYU
         GiSi/TKSCvy9GTzcGSouDDsMGGPZdrg/rA+gG7VuGuDdMs5DIoJ+6FzAHv2AfZHf6Q9k
         uSeA==
X-Forwarded-Encrypted: i=1; AJvYcCV0/DLMJovTocWQC1WGJs4wBZU7XeIRLlxOjrWPjn/SZ4z8F4infn8QTT+xfPr/zgE0Q0Z+EtLvdHkV67YbUz5O4XVxKndvtK2vly1TS8ZIOyZ1OKIQq6pLTToBQ87jIzInt6MrXLWh5FOAnOh3Xk64u16p82zo1/LVDeP7DXZ0e1fRxZjT
X-Gm-Message-State: AOJu0YxqnBZNXnUTNB3a1GFrcBPoBz+0Q9fhc8hYPRTdXDQIqAogI63/
	fbuPIudQzWN7xW+UTLCEaDJwSZSMrBX1ngqJEPYfJWGZgEy9JFRq
X-Google-Smtp-Source: AGHT+IGNjAE1LtfsrOxQVZB5wYX0vjh0z7hg7ne2W52SgHNMNs5KV8V7UlyNJC4JaNo9Xt6rJoE0BQ==
X-Received: by 2002:a05:6a00:3d07:b0:6ea:d740:62a4 with SMTP id d2e1a72fcca58-6f4e03466d2mr24573444b3a.25.1715921931668;
        Thu, 16 May 2024 21:58:51 -0700 (PDT)
Received: from xiaxiShen-ThinkPad.dhcp4.washington.edu ([205.175.106.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2977sm13917629b3a.153.2024.05.16.21.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 21:58:51 -0700 (PDT)
From: Xiaxi Shen <shenxiaxi26@gmail.com>
To: krzk@kernel.org
Cc: broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	krzk+dt@kernel.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	robh@kernel.org,
	shenxiaxi26@gmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v3] ASoC: dt-bindings: ak4104: convert to dt schema
Date: Thu, 16 May 2024 21:58:50 -0700
Message-Id: <20240517045850.463906-1-shenxiaxi26@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ee193525-ea10-4006-a86e-977e2f0352ea@kernel.org>
References: <ee193525-ea10-4006-a86e-977e2f0352ea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Thanks for your advices, I am gradually adapting to using b4 as my new tool for submitting patches.

Best regards,
Xiaxi

