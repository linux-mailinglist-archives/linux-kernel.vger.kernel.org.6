Return-Path: <linux-kernel+bounces-415224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 226319D3313
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 06:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24291F23FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 05:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFAA15625A;
	Wed, 20 Nov 2024 05:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cc6N2m0B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D6879CD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 05:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732079063; cv=none; b=Fgw/1ky5pbIriHHtTo6CF3/YgYRJF+mf4WEMYMZsYhARjDuykGn4qqaOiyRat3kiR/+lUW2yRS0EDwzLgB49GRU8xR+W/P8L5NZwoWFhnx/aMz39bWfFPs8nLeAuel/rLWy0rAo2AUVVgiqABCSFGkCET9exiJzZIAurPV36WrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732079063; c=relaxed/simple;
	bh=vDAqi2dqCWiN2YZnhNhVTCZw5+wN6pHMmpmkkkjKH1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVkZ8A0PYWE/jOc9l5co0HcoYlQzW5w9w8J9vkywQ4AVNYbR+Uj3hTlk4LNis/2U61RnpPRm2kkDR2utk/aK1cUeDPScAxBwYtLGzhLUJCN7Gc1uIhShs+mLCFxI65ALL4lV9N9XQPe73xhTbv2ooQj01vNjLCo0XKPRlWnQ3Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cc6N2m0B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732079060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vDAqi2dqCWiN2YZnhNhVTCZw5+wN6pHMmpmkkkjKH1Q=;
	b=cc6N2m0BSyJYcoHw9DCxd2Zr9bb+dcdY5R3DiAf2xATciz7QoiX56a15AEmpgGpO6BffHn
	XNjzghMaIsC/ELyDZBrOjVcQ77FJ5JCTT49XvzxRgOI7iQkNka/JqmSghsGfjAad1ldfsa
	67nTG9wANMd9Aw0yXyz5rBrX7lm26UE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-Cf3RfNJ8NPa8QyS1S66aPQ-1; Wed, 20 Nov 2024 00:04:18 -0500
X-MC-Unique: Cf3RfNJ8NPa8QyS1S66aPQ-1
X-Mimecast-MFC-AGG-ID: Cf3RfNJ8NPa8QyS1S66aPQ
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a157d028aso266557066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 21:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732079057; x=1732683857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDAqi2dqCWiN2YZnhNhVTCZw5+wN6pHMmpmkkkjKH1Q=;
        b=CDVYiF9FALF5QBNWQY+yGZfr9jMkrpRKw4dVIqiAPpX4fhZpJEQTHWYR8HPMLj6oLS
         vTieSoekyABbwHJRYwD9dygMgNrTkWRTWrvf8H9Pc+hzAw43mUD/DN6NLHY9wzVUNM9K
         bRLVRfdYay0M1aFpkyZNSn8nqtbyq3UcIZyV8PmlP9iBkoqDVrg3duZP7gFoGT/LOIrr
         Ohfanqhur8pX9+h+m9uq9zgmXllv3IaMqxE2CTnz5/yeL+iOJ5LinN/qR0VlqWEHMQoE
         R85msnKhbAZVCz96me18r1Z6W5JbD9wyW2IT4C7Pcb2BCvYnv/ugVR194bNxPgEGEXhv
         dyqw==
X-Forwarded-Encrypted: i=1; AJvYcCUCnmSzatIEDsjrnB34t5ZsnQFiWav6dO4KIEU1iIob0kAkb+F3d9y3qSJHnsjza90x0LuJYZs43wZMrxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybA7lIsOcipqkGnN04XXpUocuEcpmcQHSInOcbVhdi050yyEWh
	FWiDeO/djhsoQ0KHTtJ0NtdaGHBk+wW+PqytinL7wplmbJFg7cBmLBEIo1sJsgYGpHerxnCKUj7
	mFf0li57+y9BtVLl3y0UzpQaU14r/iApJ05UCZK/uytlJgy03SN8Y0AzKXlKKd+01d9PXB/D6rH
	rA5U9iPVclgLpAPPWR9lp13ODrwf7o8I+T7VAaNVX6HbDZ
X-Received: by 2002:a17:907:d24:b0:a9a:dfa5:47d2 with SMTP id a640c23a62f3a-aa4dd766b0cmr115552866b.59.1732079057054;
        Tue, 19 Nov 2024 21:04:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJqqbJngHMM5ArDt8/GXCWAKULtZ8n7hwb8ar5N+ZdcEu0iuznBUyULwAgVQGAf1ye5qTvujjwqCL1l80JPqM=
X-Received: by 2002:a17:907:d24:b0:a9a:dfa5:47d2 with SMTP id
 a640c23a62f3a-aa4dd766b0cmr115552066b.59.1732079056738; Tue, 19 Nov 2024
 21:04:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119134858.1862632-1-tglozar@redhat.com> <20241119102257.3df588ce@gandalf.local.home>
In-Reply-To: <20241119102257.3df588ce@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 20 Nov 2024 06:04:05 +0100
Message-ID: <CAP4=nvQ-J9uEm-mAnBhjLvy_LOzB4KvMoCBYeeo4w5_fMwbiow@mail.gmail.com>
Subject: Re: [PATCH] rtla/timerlat: Fix histogram ALL for zero samples
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jkacur@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 19. 11. 2024 v 16:22 odes=C3=ADlatel Steven Rostedt <rostedt@goodmi=
s.org> napsal:
>
> There's a lot of duplicate code here. Can you please make a helper
> function, that at least has:

Good point, I thought it's not that bad when I was writing it, but
together with the already implemented ifs, this pattern is now there
19 times. I will send a v2 once I'm back from vacation.

Tomas


