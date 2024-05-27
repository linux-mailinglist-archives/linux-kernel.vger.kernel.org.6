Return-Path: <linux-kernel+bounces-190404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5663B8CFDE1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3D8280E87
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FBD13AA51;
	Mon, 27 May 2024 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="CvWKG/HJ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39927DF60
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804568; cv=none; b=HMCbYY7RnoMvkd3oRWEeu0ah9xFxAb4y7xN+Eblf5hZ0plCvx9dMmN1LV7+Baa+tfw5f/mED/Ftb77HWfaOyMTgoVmEoeRMh/b/mxbxD04dmBwWyQDtqbM3/VUM9z+ddCqE1UEwUsSr27zUanLaG15ETJ5NOz8aPk+wtFbbgyHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804568; c=relaxed/simple;
	bh=aZ4MaEqd057Xl3Tu/Y7GeDjs3N+JtYzWYYn8cfC3UVY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=B3PZuC0lqYCNVm3AUUB1cOKzQlxMXmTGMlCB3bZ3ZLFCpZxXShysiBLxuXXlKkc0UjmJzqdQUCC3wSLwQRDnjMnAfrM24t8pTMQucG70jHftCX73GJhpDya7CqPIqiex73JNvRMWwurZ1iZt8k82Yve86khGoKl+baqDQQ7EEzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=CvWKG/HJ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-529b4011070so340027e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 03:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716804564; x=1717409364; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMH3UkEu6/RcdYfYyNBaHDRYNbs+NKh5/urWdRiWtOk=;
        b=CvWKG/HJKyhw6tMldspy4jkX3/MJHBkbfvw5feC+sKI04krJ/sJeOVDekr9uCfoFkZ
         6fbBZHkDIaaFJ8vIEnVKyk9T8NWqEVq67y092Diyxb3JAZNXaghe79vaBwWofH701wIl
         b4Y/xE53bXyyESSGt9eab1yr8OmgcYWia5cuALAhmU4ESHQOHymCG0Lowg0ljrRvitZI
         Ycehg6K2LAlp6lFpmZETaUwZsoOS6ijSfLQ1Z4OdvTBlAwBYFahfWuGk/mQ4+0bFhX2G
         y1dsX+pKRTrtnfNNtAiXmUDWz62Bm5snbEe1vkYh6x/7tpSWmIVmM067Fh6tYLdxER90
         kKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716804564; x=1717409364;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMH3UkEu6/RcdYfYyNBaHDRYNbs+NKh5/urWdRiWtOk=;
        b=h5b54DzQ9SAeQ/g/q2I4ERjXg0Z0TwwJ6Jg7KHnr0xSTPnfDG/rNeYB1xy3qGo2vj8
         yJhhCgikf0cTBB4pIiTDkqs3YGnyQPIu/EFQ1Cn4s25Lfuop3oubZYNRg1x0JWIKl4c3
         +OqjDNyU1GEAZBcvxTLNaKaEBx38GmDru0js3tWTQqAcSsvffvGKw+5woLqNFxP8A0vL
         wk9FlMQ0xaHm5LtUaJ7RT6uR8TJoDvMeamtIFdZu/9dzDsaZ+TzDDSNvSHgVYrwigW8y
         aJ3JrSFsxmrK4fOeS+4k0XPq1FeXMM+z2ezSVId1BlxrSdy6FRYE512Hf4SARf1awXWF
         ryEg==
X-Gm-Message-State: AOJu0Yx6l0EU5m/Vb/f4DrPUYsI8rUqAra62LzKIa9K4WaHwyIhAtA1W
	Qy5gOmitnh2gnYuJiiqwnZHFs+sKDgW8AHjni5e/mLbw9eyCvNoWz25T7NK0gWsY3bteCg3dD6h
	5PKk=
X-Google-Smtp-Source: AGHT+IEF/5VzncQiFnULFcnyyA5N/TZrJYk8hxu7tEF8PJ0jG3qviAz1+55bJQVfrwoxK/7HeZwsAQ==
X-Received: by 2002:a05:6512:ea2:b0:524:34ad:ba77 with SMTP id 2adb3069b0e04-529642048eemr5635804e87.12.1716804564266;
        Mon, 27 May 2024 03:09:24 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:aa3:5c01:cd9d:f244:3bcd:de57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089b2470sm105502115e9.33.2024.05.27.03.09.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2024 03:09:23 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [RESEND PATCH] w1: Add missing newline and fix typos in
 w1_bus_master comment
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <86fc563a-f542-4e02-8a95-b93aa6eadce9@kernel.org>
Date: Mon, 27 May 2024 12:09:12 +0200
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <64E0D2CD-B53A-4890-AFE4-46DD2A4144B1@toblux.com>
References: <20240515101150.3289-2-thorsten.blum@toblux.com>
 <20240527092746.263038-2-thorsten.blum@toblux.com>
 <86fc563a-f542-4e02-8a95-b93aa6eadce9@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)

On 27. May 2024, at 11:41, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 27/05/2024 11:27, Thorsten Blum wrote:
>> - Add missing newline before @return
>> - s/bytes/byte/
>> - s/handles/handle/
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> 
> You sent a patch during merge window. It's waiting in the queue, so
> timeout for pinging kind of started yesterday...

Thanks, I didn't know that.

Best,
Thorsten

