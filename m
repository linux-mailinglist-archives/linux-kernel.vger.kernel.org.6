Return-Path: <linux-kernel+bounces-430400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E839E306E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB74B243D3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6725E4400;
	Wed,  4 Dec 2024 00:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SXeiRg7h"
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4464B7E1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 00:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733272345; cv=none; b=Kpa6/NdtQBU6co8c8I1uSwPaMy9jYfZGJj/YVXdboRFoM1PYQTi+6RANiVdQchK3sSPEHMK+QSin/MN60fAizEiPaejy4ChL9sryUym0BHeWxxZZSn25oAGlOqzMeEkifXFs9DjQ5g11lstT1jI1KMiDdwKz1qf/MgAIje1bx7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733272345; c=relaxed/simple;
	bh=DDxKSHEx7Y5/1b2cBgBNTQdkIC0rcPSiN7X0JbUIXRs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EH+LpxNonjSsLPtyuh9oAssQ0Xt6KdBS7ZDuk01yJe3C7rG8aa2Hw8xiI/kMeiu34/Dm1mDHYU1hgbFumbkyq5OlcxaYrLaXQWsFaXZxXoOB2cPF3VQr3+nZX4vpYGRMK7kqHFzjKCNB9goWjb4Ba9og3jOK7wAtnnYFe0oqE0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SXeiRg7h; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-71d51b281c3so4216227a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 16:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733272343; x=1733877143; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVEYC1nSF+KpKxk0nrXJnLwZchetOwjmEdMmnp1zFto=;
        b=SXeiRg7h/m8nkBbgca5lPCXrePc9XtchMzYitUKL5cGgvSedMcNV4VKPEu2njLdgUn
         b2EcD/VLMxWlnHfBEP4quGKmjQzQQrt4QsGZiglw1Y2sZoLR9vDYAPZ87VDeG1Svng1n
         U3Oet9rSCWa1FizXkUkNPWCljArnJJnpDfWCyLTdrV9nJKXpDGjXa85buWDmCar1cbQg
         8aIVtfUTxKP4hPZmwSxlPaoq8ISUspC0gOhCJjdSIzeBlQ6pGNh5JFESbK07wv8hg2JP
         mZLMLUDROGnTqa9C1mlUXuBdZwbDvR8CyRvIv+hfggXNTA2cezfAIqhCuDR9dXIQ3FCM
         Db9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733272343; x=1733877143;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVEYC1nSF+KpKxk0nrXJnLwZchetOwjmEdMmnp1zFto=;
        b=wmv2fiKoQfbDhtM4lkriFiUo6RKiq7gFf3juhjk5LTpAAjsxZs5pHTXk6FUK1DWK5+
         RSNJGu0xDRuAbiVk6xQcSd0udXjJhATQFI/qF+1QHZ0jwpRymeQqsz5RyJWJA87Fn+aF
         QXP3X81Icj6UsCDSf9K0a4jLwTbUEjL04mTGBl8IvVeoadxYpa1n5fGwNEfD5qAJgWoT
         9SAikn4enMYaej59oLhYXud0GP9TgEux08f/+OW7slWci2hBLEczY7RL/xhEH2epUjC8
         OGgy/0rhZSGcgR2dR5zYNFPY1aBsBchFpzaclhuiDIrn27a3js8fGHuHAbv1XHdeisWY
         cWuw==
X-Forwarded-Encrypted: i=1; AJvYcCVZhlnvHlwR57PNdRuGHB1rbj8HOwr5ny34i3qdB1XxxZaZ+lidEoHRNTDzqSHw6lgm8K5NNzdZo2495Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIcuMyPFWEtYTX4G/MV1I1rmgqtX6PVOJpRF3b+2cf2ta7ZVT4
	URAH1OxqZ9PDnhElUQP71d4U4GIPeIAGrpFNumj+Y8sR49nvZUF+UY25SIkLZHU4BvFie4xLyRz
	P4Q==
X-Google-Smtp-Source: AGHT+IG3G4WlbRtafcXmxVI3VvzpVclTwXmcNS+SNcH+C52y2UYIixbvldZbsL6Jo2VX5UVUh+NaGYov2c0=
X-Received: from pgbeu13.prod.google.com ([2002:a05:6a02:478d:b0:7fc:f798:21ed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:6e90:b0:718:9a8b:5bd6
 with SMTP id 46e09a7af769-71dad5f3843mr6139466a34.5.1733272343375; Tue, 03
 Dec 2024 16:32:23 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  3 Dec 2024 16:32:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204003220.685302-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2024.12.04 - CANCELED
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

PUCK is canceled for tomorrow, as I will be unavailable.  Sorry for the late
notice, I meant to send this out yesterday and forgot.

Note, PUCK will also be canceled for upcoming US holidays.

Time:     6am PDT
Video:    https://meet.google.com/vdb-aeqo-knk
Phone:    https://tel.meet/vdb-aeqo-knk?pin=3003112178656

Calendar: https://calendar.google.com/calendar/u/0?cid=Y182MWE1YjFmNjQ0NzM5YmY1YmVkN2U1ZWE1ZmMzNjY5Y2UzMmEyNTQ0YzVkYjFjN2M4OTE3MDJjYTUwOTBjN2Q1QGdyb3VwLmNhbGVuZGFyLmdvb2dsZS5jb20
Drive:    https://drive.google.com/drive/folders/1aTqCrvTsQI9T4qLhhLs_l986SngGlhPH?resourcekey=0-FDy0ykM3RerZedI8R-zj4A&usp=drive_link

Future Schedule:
Dec 11th - No topic
Dec 18th - No topic
Dec 25th - Canceled
Jan 1sth - Canceled

