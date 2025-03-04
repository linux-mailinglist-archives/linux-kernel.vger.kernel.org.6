Return-Path: <linux-kernel+bounces-543777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0233A4D9D3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97111897A99
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8618F1FDA90;
	Tue,  4 Mar 2025 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nakDaq8Y"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB518225D6;
	Tue,  4 Mar 2025 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082989; cv=none; b=WIyy9SvY4WRAhuYTvi0aD5ppsy22nkcI5Wzg77/OHgsisX98RopOjqQtsOSEw1HWE/vsF4klvLNWQe1G3uBiiZ2Vx+FAJHFR6sO7RIENIiZ8sERhRsrgFqdRm5+/Psr1m24SaPTgLf3HjFMmaqhCctgm3u4xGBfjdIOiErdTJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082989; c=relaxed/simple;
	bh=sN22qP9PHuqHBrVUW+81ofUl2waI0KRpIxRfstJLrkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgOKAvQuimCiz2nJ1OdSeyf5Vr89WZz8FEefl0/3Rynk4T9hRy5Zw054idimG8vzGCPx96igX1Iv6qYoUhp1IJi5EsnUURgc1ByjCQevFfjYc/aZr2rPShT30c52RefwiigfzH7ThB2Wj+VUtTSWJDiW0RDsAzlxHZQhu6a7Wlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nakDaq8Y; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fe82430bb4so1446744a91.2;
        Tue, 04 Mar 2025 02:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741082987; x=1741687787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERN7diVe571lVikT49/v2kMDw68tmDpGY4TrvA+K4j0=;
        b=nakDaq8YG2qtSiRDiuG6Lt1sIR0ypat/sb2HEnZdyAKZGh6T4iIXI0RQCdVeevs1KM
         gn6nf3FI8pjFA80WR4NPbo5FXtcSVVMB1EbYi+NsEpZuLnRND8OES3iJuGVH/ucRg0s0
         oWBEvidVF/FQCV2qGedGkrqCduEYrLORep1tIMcxk9rW14+tRHGxpxk+pGNg4VHqIQbo
         oFyap8cHnvdNvyqRmfLUYTf3Pg6WV1S84cM/xskovRST6LqW+UUeBNs2dUC9YLpYvrb/
         EyyR/nRvsE6Kn+HvkAK419crGxqLkUO/ct1wMKTVTcTDmgJxJcE6L+ku0aqLJZTxtvdj
         KByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741082987; x=1741687787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERN7diVe571lVikT49/v2kMDw68tmDpGY4TrvA+K4j0=;
        b=Bl/KZQ6j9/dlkbpRoDVpBk0/GHhN+odxuW9adyDI9G0SVsyJkufU3v0yHMDKLGa4Qm
         oz6CTR6rLynbF4T76Sq6meWTJNab32I7GBj3E7itdAZiznVX5D6pO6zh7DOi+oErT1LI
         iREUSYwQrybEHquV+HCxh/6HmjAogh0p3yrFcA7+u96Uk2l2VLlniMjjjxsmJ2lHe6u6
         SmYiVf98075VZMYaXUgtmeFD5XT5ek+TEWcct7yzfMwIfDZxHRR28HnUAAgCQnD1s5qE
         2/uqGD9HzZwbTbiC9MDYq1nMSUiK+LlL0HAXLm0t34Z3GHwUn21i4N6rJiyMso7JbXQk
         bsAA==
X-Forwarded-Encrypted: i=1; AJvYcCUF48aPZDpDnbpxX9AhN4fZ4n60zesmgjOAeGXKsq5X5t5lqHQii17auVoSJaukOzuvWmGEzrSRAOUvCLKQRo0=@vger.kernel.org, AJvYcCWUD4DR1GGPHyL2sfXZqmOq6NTL39vLH90aBPq8tXOmD2ODRZggsX5T8Pdt1LGdMaoL88ae/Kgi6fyR6xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ewyG/TVYiGp3jbivPzLcS3h0CRzIDeFcRl3OTy41SUz3cVE6
	z2qH8kxKqk/ZriYvjf1KoZMDhBzMeMkyHOdMB7nZ4TCILKwr9ulQVXXxDLopJSqJ0TcCsYBh7Bl
	5Ea3sPPI5Z4xGFAHlCkC9+uI1uds=
X-Gm-Gg: ASbGncsZZ7W2wk4LiD5gQWK2wcssWXsC9CnkSRJaMf3ZsfG9f8MjcMcL0IVUNtlO5vx
	9LP8ML1RZAJPZelo8dPaGNMHgXcrqVl+L8K8zx0pD5GQQPQ1Rb0qNt/7uBmJPKkIhqyohpRB+kM
	vJjxFwZJ1niSBaGOpbGJ84V9F/wg==
X-Google-Smtp-Source: AGHT+IFseN2+z2lYv8glz+eJOuVumErTdOblnU7bMcjpSO7VXdKzX6o3No+XO9527+1TY40dPn08a6YtpsEue9e8lPQ=
X-Received: by 2002:a17:90b:38d2:b0:2fe:9730:8e42 with SMTP id
 98e67ed59e1d1-2febabdee63mr10089868a91.3.1741082986991; Tue, 04 Mar 2025
 02:09:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304040450.697235-1-sidong.yang@furiosa.ai> <2025030451-polka-lustfully-1edd@gregkh>
In-Reply-To: <2025030451-polka-lustfully-1edd@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 4 Mar 2025 11:09:33 +0100
X-Gm-Features: AQ5f1JpmdO2O7KOha9l3o3OBV-Z6_NOKk8RBDswJH7SVQQMJMWrOnvKM9t-A3WU
Message-ID: <CANiq72mShwVOM5DSSH8hOj4sxx3Xx=pk=SHN5nHWCZEJ+DRoCg@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: add cdev for rust bindings helper
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sidong Yang <sidong.yang@furiosa.ai>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 6:42=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> I think you're missing the actual bindings here, right?
>
> confused,

I think this is:

    https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/topic/=
trying.20to.20implement.20a.20chrdev.20in.20rust/near/503177362

And, yeah, we don't add headers that have no users, and we don't want
to promote avoiding to write abstractions either.

Cheers,
Miguel

