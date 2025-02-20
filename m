Return-Path: <linux-kernel+bounces-523381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 212D8A3D5E5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBC7175E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF691F4706;
	Thu, 20 Feb 2025 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGFTHC1D"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9661F4628
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045717; cv=none; b=cAklyNbAJtIMNzlHeBdN7eRa8e1snVG/dx+KP5uT5/8Dn1qA32tTBn4M71BSAiieacbKTRh81x+T5dRwTy2DRMVlQlKAXKD/s2J+NvofhBOmf2ql4ZpwLyOtD0HwKuIsRqHAsv6hOkiGXkVMltjqGtKNbHCGBhyH5YSI6EqDdpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045717; c=relaxed/simple;
	bh=zoFjr08aXCwnVaT8N8AoYYhHFJ2FM8ACrA3XiXjv+yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ae/4IaBnH9StbEBlzmUUwoxzze8tikPgDNebW5/FiwxTabXXk+dcQtB2ZCWrPgTMZ662CbmB3KQAjlmHL+yaAgbEdDY3NnDoGf24fryUGVmNjiaQh5MeZfo3dothgiMXfNTPKJ4hR3lAPEBWcQI1YQZqHMz0DnMeRM7v8iuLYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGFTHC1D; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5462ea9691cso885431e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740045714; x=1740650514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoFjr08aXCwnVaT8N8AoYYhHFJ2FM8ACrA3XiXjv+yE=;
        b=EGFTHC1D32Kfnca8uT1s0AzINojtrQfO/EHnwjlUGmlvqXYrw000y8+8yJ+aVjTNXV
         Ak432XcP/3jvTeDvSFcvrbnLES0mx0ugvcRrnybaS8hlEV8709EZiOZajL3P2lYYgqx2
         8LLI9ucpPIe6IhlpWsPGOsQn/QY7afyNNtD5hV1pGfM0W0zX41i8BzQdZcYkAgoQmjin
         qELO+t0ujqj5mDekgv4OV8OWNHmxyEs+LdEB4PZDagajbs5A6rZYiztJ8rd1jIlwyslJ
         Mgr45iCeV7aHn6SkIFA0I2zw4creDlEQbLBub8W172UJyLCge5zRDPloNz365xm69WCc
         NCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045714; x=1740650514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoFjr08aXCwnVaT8N8AoYYhHFJ2FM8ACrA3XiXjv+yE=;
        b=oO8TGOR1fYWcgUig337SxO0uChqpF4jBzQ/19JWSxe1h5vn+ExzIyGwAljkXnFhztd
         tjhbZDTv48vmrClwIrfQtB+PCJGm6PyWGTyMKkdahDMSSt8VDYxrr+eA+PppmgLnwgK3
         C+Falk8q6ZfgC2d48fW37s95hBKOcGfOpRo3Pu5vQKPDjuy26JAQ/7+SYNkDLqSzmma0
         /GEETabksSp7v/WK08PAYdD8aozoAxTiyId2YzM0yof/lhMwE1b7zGWd+fZwE+Y2gX4U
         R+9tQjQAv+agvZUbiLYPg4xn67qUDfEBvHLtPbfbOL+E18rq/KTENhSQ3fS7vDsBIfPz
         7VVw==
X-Forwarded-Encrypted: i=1; AJvYcCX8xvHzDwCiLDsJlPWheLsGDZ1vEELNsN4zAIeXFYh4O/xD8tyibgZFyRFEyQkPmg/IphP/i7fmB2afwqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlRz7nqU1nHGWTFX86s4zFMaSrliXESLNPU0twSncoZei33Jue
	/kLc9l3fToNF3nbXhfWl01wLufMrQodv1VtrRAvJPq88ZemaYbGrL+lDsgxvqOx1hEnPLPzI76X
	J8JIVJaHeJj5ktbdF0j967B01B7I=
X-Gm-Gg: ASbGnctvBq2XHWkIUnu538sMYxP9pcUcHn7lMd1iJ7pwgDphrZMxE1drPpm+CXkKNIw
	u7gosZuV1EGR4qp6HaC+2IkJNgbx1vBwGV7icBwoUytO6opKB7VaIGgu+M3Pfvx+ON+JBn8+5oj
	M=
X-Google-Smtp-Source: AGHT+IE776qp3jN6n9tegTYmteckduIV2mwQRn13Jm+yWrMasZfBROhiMgcJbIr570ipWAOo66p/jBjJm5g6x7AzTq8=
X-Received: by 2002:a05:6512:132a:b0:545:2f0c:a29c with SMTP id
 2adb3069b0e04-5462ef158f5mr2846077e87.36.1740045713762; Thu, 20 Feb 2025
 02:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218124428.1638816-1-rand.sec96@gmail.com> <dmsdrpn5c5x3aqsgjiapqem4akvof2jezgyj4liqkeveo2cect@lb4s4krxfhtm>
In-Reply-To: <dmsdrpn5c5x3aqsgjiapqem4akvof2jezgyj4liqkeveo2cect@lb4s4krxfhtm>
From: Rand Deeb <rand.sec96@gmail.com>
Date: Thu, 20 Feb 2025 13:01:42 +0300
X-Gm-Features: AWEUYZk2cB3JQpk7UIYlPObrCYEB7DRX2RBVdGy7mYirXf3nm8O1wqcwYmkH_4E
Message-ID: <CAN8dotkL9U0a4bSx1REYm+JkdfwXjouOSEa5Yh94+V0NJRYRQA@mail.gmail.com>
Subject: Re: [PATCH 5.10.y] fs/jfs: Prevent integer overflow in AG size calculation
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, voskresenski.stanislav@confident.ru, 
	deeb.rand@confident.ru, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 1:43=E2=80=AFPM Fedor Pchelkin <pchelkin@ispras.ru>=
 wrote:
> Same here. The patch is supposed to address the issue in the mainline
> first.. What is the reason for '5.10.y' in the subject?
>
Done.

