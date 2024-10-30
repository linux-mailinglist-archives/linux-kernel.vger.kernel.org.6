Return-Path: <linux-kernel+bounces-388474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B819B602D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BECE61F21C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BF91E3DEA;
	Wed, 30 Oct 2024 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b="Iykr7Ft9"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391271D278D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730284335; cv=none; b=jIRmNJuPcUg/esv2yYgWVHGy4DTlqYrDYScz7vCmOwv9b41rEFx/7thhjHWyg462QANxcEZ4r04bYvoTR4puzZqHH0LTswOS3EkL1JwttqDDeSGCkYZ3xiIu4bztN1tU0mcdhIyT/tdjGiDUqQpvm1HG/BmYeKk4F4pYMfjw+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730284335; c=relaxed/simple;
	bh=BhsA1aKlglGjpRdMu2peVecDmERAuTyLLhI53Hw2hvM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=hCw/mdp6gYkIYVnEF7SDzjD8H7K1EvIa/+wvOGuaBsTy0Cu91djQ+nq9aChPZjjNPFoi14TMT0Lp5SK8QpU0lntVfK37cNUzT7eR8/JkyCUxCtUaSIJGHENF4eccexic2VlgWMvQvF+oyAHfXohItLpjxGt/DVMXBy9DvCh9cyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b=Iykr7Ft9; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730284330; x=1730889130; i=metux@gmx.de;
	bh=BhsA1aKlglGjpRdMu2peVecDmERAuTyLLhI53Hw2hvM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Iykr7Ft9FuTGiPMHAI9E++CbicFsBYya6pvBj8sgMxMQq+qZ+vwVkUBtFh0eaELJ
	 fUI1NLksdKrhECy7FnsMf6NywjUSzCqol65tMtRwaxyCLcxJHG0qvHTKilGabTe1H
	 tLezR6oyb0S+m0RVOoAfdnxvhYy6mVaCBCpPao1TzXoh1vZOdg4t7Qr9p2N+osFLe
	 Vrkmqq9zOgz4FA6dmZtc+i9Kg6wIjsoC+tnHTIqzT97Tf1Xr/dB9Y0vjzGSTEq6fG
	 4ffZ5wbBxg0NZOj9QxqQz5BJp6AdmJXDU1tQeeNpWlzRggJvYKuQy01sH3iptmQq4
	 HxbkQzXCLXZG49tbWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.178] ([95.114.207.188]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MG9gE-1t52iz3VaW-00BPTw for
 <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:32:10 +0100
Message-ID: <5bc4b931-34d7-4c04-9cd9-5dab6c4dd794@gmx.de>
Date: Wed, 30 Oct 2024 11:32:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: tl
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: metux <metux@gmx.de>
Subject: ping
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dwnG4zwMbP57jk50+osOCpcmXuXLH8ylwz4S1F8XRhfOD8ImW1j
 e9xiN7vznUKNQNsIE8xzKejTHNCbHaaD+Ux7Wd09EpotGRYGDV0IgDKjKDkCZciBj0PPUSQ
 S0yIsYC6YgSZfG8TMqc8Yq696RDX4AFgreG/6N1Y4iPqQP3Xk3MQDVcldk9/ML1usnQ1LmK
 u0J+Lo6RPkt2jSEzopFCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wvZ0NcVe9Qo=;TyO0DKs1TxKpQoMIHtrDHmBGoX8
 W77UN7MYbLJnFWKnsIY4MVpQHS+imNGJdZPi9A/s7GYYHchJ/sMFceZrVUvCShPxDX4t15sV+
 gEt5Xys4SXEwydBofGak6rdgkE9w+FtXnS8B91FO4yi+RiqvVcZPJL/bZVC2pwohJ6N8H47EY
 5N56QtmdJnjSuAAm49CSxiPs06jUFOpASlnUn4qP/zh92jWD3PFcjKZpafFXfTuz53q2NLXtS
 A1skfidjW9ReG4iB3zaNt1Dq5vyNIGrL93SLTOVcMT25PPVFoB4ZLXifzO6H8S/kYj1sk2lkh
 12LroLaoMeeV2GxNdtDYyOnP+yaIRd6uoR1PqNtTfUSUCdUpbCY1946aWzaKIramEacYEjcjh
 Pc7EW/q3w0rNGH4TSDLsQQWGjh/q1Jqhzjf/3uAzgJKO64r3bEd7/ItASrFCVelyQZnx93icf
 RVTuZELDCJO2E6XJ0KBNRwbFRuAm4hdN0tUbvzdJd9TetNWvbeZ/idZEDgFEApBd1rNL6OKKW
 RiDWezqaQSLVofWpScz8jVFIWczHQNb4wL9tY9Rh5wRFM2Y3/K8OXdzZeEZiuPrP7F8AiQZ7L
 S5awmdW6ADla5rEsxA9PHTTxg+8Zl9vdti80RIDFNVvPWs5sK214nJFh3ghvTXzWSkn/kKeU3
 fkrX4NgHCzk3D0YpdxsTB7UhvQOojsGeTSPIuayvwOTwXu+vetlf3EFzUwJtwKiS2T5HDmiTg
 oQ2wUj2D36fle3BJL/3a/E6zARhH13zcGIbBDalrp7/A7zxu2p387SEbiin/X6eF0Wp8QEiCP
 Xb6+HaGbxvS8S8QtXByTCYxsr+dcV4GiTFMtLuXRBz9i4=

Ping

