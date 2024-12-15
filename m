Return-Path: <linux-kernel+bounces-446447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA949F246B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 15:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9357716593A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0259A19047C;
	Sun, 15 Dec 2024 14:41:26 +0000 (UTC)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B19A154449;
	Sun, 15 Dec 2024 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734273685; cv=none; b=q2bpiZ+QSgtXVF93VkzAXWNj3v7zn28hus6s3LnC+qmEzG5IsnOCsMnuttJm2++3xnxr557Nr3c1wS9M4rtYkF/6sdddL93489WNejONlicUbkuWFQ/c6hEet+bGZfxNbCdjWc+FZ6VV8gGCs+1Hqb+SYGqVy7O3Q12lyAgSqI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734273685; c=relaxed/simple;
	bh=kXeJ4Hj3hzzePfAjpzKGNKDxMpqaR8gopxSh0vbf+iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEoUL+N7qpcITwp2L+/X6vnpDcAFVInPWlYUlRa5BwMX7DGBtjRPP7scUzotzZjwb+G7UuVQcWQSex3PfhGWNULBc1cIIgnpllr0rr7Tal5q1FR8g/ilcU5lRyWsBR5Ko0/SYdrsmQ/TKeosbw9GVXfDCHbioYd2Xbnk8dE2KBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a7deec316aso11279855ab.1;
        Sun, 15 Dec 2024 06:41:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734273683; x=1734878483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCbNs8+4+AyZ8aANBlD6tglNDCYClZMZKU1hKK1G8O4=;
        b=jYSrGOrAPNjYnaybFH5UBWN1JHFYRLoEz4GwP2IhHEq8+6QN00hIrM+ZbgICd2YD4k
         Mvyg66gszGe4ORInNLVuXF9H2Opgq7Pnx+fyZqPowsqGkOTiTaJC/327Aq0CZqSP7pag
         IABS/cmdwlOg5LZ321ImL+sofnmcDOX0O0dRsSj/3p1fgO5xlJiUoNRrtPjsfytQvPmr
         mKvNoS5LFkZTpX/ydQN2Ltlsh+/VeDZ5eLg8XGIXY00vF9tir7FLrgOWlpszYPS67vYq
         nePOTJ++bjunNZSwJkT7pxv2DQPf3RvnfCAGPf0u0ZI0yM3RhFAGxqBxe6XXo322JjhN
         AInQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEh51/MgCx7bmFCOFnsVpaP1aQdelWDVTYpwfdbnzO/y8BiGf9H5KHS3AB4tQuqYecwnVvKcPLyRo=@vger.kernel.org, AJvYcCV2WJOqNua/dxLJY7K6v2cpy5DNwvwDiE4XmCIRWG1e0dryYdKpHmjzTfaEJUI+Cwm1LfZi3wpDAEDeZUNvt0v/VMmbGg==@vger.kernel.org, AJvYcCWCYgrPwHK1Gz1zqrDpo8AsB4wrmIkRBSAOEIpB3w/X7Na/wA3SSbdaIDOf922IaW+/a8B/OCkQXRgZzZw=@vger.kernel.org, AJvYcCWHo2rbamjowPd5GKEb8MvpPfy+pb2B3fajkkgNICQn/gw5XkTZBokInUzUQXAQRYZbHtwm6DMiONeodPbx@vger.kernel.org
X-Gm-Message-State: AOJu0YwUJ/9VpDo4k7+rSuIQdmyEFRezt73HSKveLHTLNhie9RxikTRw
	xzd5IisEmzig8G5M2OSAPLgUlqmhvjhU/qz8krdV4/gDVVycIdo7mXEInhZL
X-Gm-Gg: ASbGncumO7EAmvtSUVAhsjVZ/aWF0+LYUWCku0teAu1EQgCWiaFWKQJElaI4dPzlK8Q
	3A4GruimSyjTHRO0KdbdSAb6819k34N6Pw/xGFBEhsX5SqyDMFhX3bnRTNkf2UH5Gh074eXeBV/
	066m1a7UWWPlReICyzLH3e1lHBk9hKvFwt9deWwniQ5Cryxel4BlEnhcsW7Oe1EiVMkY7wDTL2f
	nqOBpWkVXsijiD0tI9FJXs6Ex7qCD8WZxsJ+R1+zCgou3wImAuSsMXelCcmZoL85676KZJZPbxn
	uSntK3OFQii/xb7KH1kfpyoNNg==
X-Google-Smtp-Source: AGHT+IE5azjUemih2bn9mL8HN7p9hsVWV+OTQ+fJo6vAOTxz8pkdam2ceHeCpuWz4QAQQHBrMWQDdw==
X-Received: by 2002:a05:6e02:18cd:b0:3a7:d5a6:1f9d with SMTP id e9e14a558f8ab-3aff5397ba4mr88667175ab.9.1734273683145;
        Sun, 15 Dec 2024 06:41:23 -0800 (PST)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b248228c19sm10307255ab.28.2024.12.15.06.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 06:41:22 -0800 (PST)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a7d7c1b190so11385895ab.3;
        Sun, 15 Dec 2024 06:41:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhx92qdN/j7QtYzGOuVssOpghvaalWwrBAT4xZaDmg8JEJFpS7KYhmvRE3XTOod6XPQQp0yweg5h0=@vger.kernel.org, AJvYcCVfckoV4yx52iAQ5rTqhLb6YLSHVsw1TTGVjVhtzo8lBoK3Pt1Pfp8ddpy5GMMYNiNaoBfBCRfWidcfgxiP@vger.kernel.org, AJvYcCWdl3CrmDV0W3G51oHcfZwAvPjVFjZy97qb5XxwMuMHGW1egrq56i5pp6RUPm6fRQJbUMWqDggAxXycM5M=@vger.kernel.org, AJvYcCWt3+cczbPAB/yMGFEas2imNvAsyfIElWU/WcH/6tlGv9jRTuFs3DC3uWygCIcfBzvVaiyJ/6Lr6rY8J+hTkytZsVIYkA==@vger.kernel.org
X-Received: by 2002:a05:6e02:1886:b0:3a7:4eee:b7b9 with SMTP id
 e9e14a558f8ab-3aff6219ff1mr100318725ab.13.1734273682673; Sun, 15 Dec 2024
 06:41:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209163720.17597-1-josh@joshuagrisham.com> <f8db26af-c6c6-478c-a69c-0bc811e0b59d@roeck-us.net>
In-Reply-To: <f8db26af-c6c6-478c-a69c-0bc811e0b59d@roeck-us.net>
From: Joshua Grisham <josh@joshuagrisham.com>
Date: Sun, 15 Dec 2024 15:41:11 +0100
X-Gmail-Original-Message-ID: <CAMF+KeZAGPYLjWujOpOk5esuX5XTFXzWgUx+baTrTskQ=jWqFA@mail.gmail.com>
Message-ID: <CAMF+KeZAGPYLjWujOpOk5esuX5XTFXzWgUx+baTrTskQ=jWqFA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: samsung-galaxybook: Add samsung-galaxybook driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: Joshua Grisham <josh@joshuagrisham.com>, ilpo.jarvinen@linux.intel.com, 
	hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, corbet@lwn.net, 
	linux-doc@vger.kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Den m=C3=A5n 9 dec. 2024 kl 17:58 skrev Guenter Roeck <linux@roeck-us.net>:
>
> > +             if (channel < galaxybook_ptr->fans_count && attr =3D=3D h=
wmon_fan_input) {
> Why is this check necesary ? The is_visible function should have masked i=
t out.
>
> > [...]
> Same as above.
>
> Guenter
>
> > [...]

Hi Guenter, now I have removed all of this from the v2 patch for this
driver and instead will pursue support for these fan devices directly
within ACPI instead! Thank you for taking a look!

Best,
Joshua

