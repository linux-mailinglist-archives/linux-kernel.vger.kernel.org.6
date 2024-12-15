Return-Path: <linux-kernel+bounces-446488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1D49F24F1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 18:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525B81640F4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7901B21B2;
	Sun, 15 Dec 2024 17:19:19 +0000 (UTC)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C444C80;
	Sun, 15 Dec 2024 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734283159; cv=none; b=OTuCNl0m61T8Zx5vIOl8q1YE5dFJGuKDchvgtWpdgGdVDRNOobg/pdV4Ss/0rgL1y4vqQpqYKaq4ySo/fvL9AJzPNbR+P17gN8sAdZQJ8d8riZuURVRtefJDkICH26ARzKDP+AWr/GIEKCX2nFLp69HEoi6P3buxX+WqsobaLFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734283159; c=relaxed/simple;
	bh=VLLIFFfZjRNCqSFV9N7ouWWj+51Vsf6GkaxwTk6pktY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udI+kO6IAM7ktXOpfueAk2KQHdBXjMu0mZ3XGBQJs1U+J5qWFKuHrbr7tzRmLET3E7Sht22Uj9668eoAtmD7RFys3CbiRjEV+0JdbVfvmipsVZ9VDO9GBBoUAM7lJ2r4d/bKZj/YcARuLfVovHaAka42DHOdJdQDxodaujxgA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a9628d20f0so24906685ab.2;
        Sun, 15 Dec 2024 09:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734283157; x=1734887957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLLIFFfZjRNCqSFV9N7ouWWj+51Vsf6GkaxwTk6pktY=;
        b=G62X6QKsu3wSuvA7WA27Lr9sjFtPgq44inibLWZwYayw+j/JIclhWwHugZxcpO+1DU
         meRFl4r8PBsnFVRl7wbq2DYhmMZ8G4bBdOcGD5kalIHw2nH1Q49ev1/cJwLyFF/ipSl2
         lMNxqd+jvesQwdqyw1JnTVdpAv8D2RTnb1kOBvVWAhqwAUw5xrsBjsm9qI3itHU/Dqga
         gcSHboalXIneS993Sk9TYx7QAXK7IlmRRFEfxWI6Z4/899Cs8VUCxk71K2SZzqLBQ3fI
         UzEM28uCnBVDpSXObTvc3E90DjztYzuz4/PlimrBSdKv06ZtWVIaer1rGuSmnbPgCYVB
         1g5A==
X-Forwarded-Encrypted: i=1; AJvYcCUKpyueJvDBatPtjFYeZQBgAzt+xmTpxOdY0pG98tktOqk5aSCDITzf7tLhm57wZE9l6jYsRzFeMOixcM+7@vger.kernel.org, AJvYcCV/Wh4fB1bSeXqXa9RuRaJlywOf28+9OKFvGqTy/6YBEmTvZwq4MroeB2ikbCegjxlTUhGa92BbuwU4AL8=@vger.kernel.org, AJvYcCVxqKAG3yFXxnZGfTLHXpZmRPBJ+hTD2Ublgn4w2MabtPbH4stdpAzbiPmhbhsX1OV4yGS2uGT+3As=@vger.kernel.org, AJvYcCXsf1XPGEJEuIY7GHNxAGyr+S/KfrO57hXK5lO1ww5j7ujXvtzS/6biltEvFowu/I7b5NJKKlvvgrdVyaVWfssTwOOXNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTPQywRoCDYRcL4wAInPHPCNrRU2XYZdwQQ6oKksJ+M/NjUFiu
	mAkHLrT4sG23zJZjoOFcOE8MSZqa6cUY+KyuG5WAgITlHj6/BRUtf+RGw8IdQsY=
X-Gm-Gg: ASbGncsrnyml0zNVrVMzsv175E/SMw+1XtHWHtp0OF/Q+9rs5DZTAC0OtpjX+FIxsas
	jydzufbp1VRaAmEEYbEtHJgXKKLM5E77kNv+NNkvvKUH+ofe8MMKuOEFAEgrZuooWAHDLvJSb2Z
	MQQvdUuuz7uP8xNoLu9n0ZXiHMaUg7z4uX5v0vG89Ht8sPLhY+dwX0mPqzD4wbKGoedYYHfnqub
	u6HSpQy0T7hAdrY4zS3tKVdUXlPXKmZJri4AKoMJSx4a5VHkXJ5z3JCJ1KHsPwpuNnUIY35W1Ma
	e+CdrSEDF0VtQCMes1HopQ==
X-Google-Smtp-Source: AGHT+IGDnS6htgyeYwgN8UIWy811+V2pQ6j/vx6lcoSMVf67K+GmREOHICZc0pcKrjcHl1lnmSxE8A==
X-Received: by 2002:a05:6e02:138b:b0:3a7:e0c0:5f25 with SMTP id e9e14a558f8ab-3afed372568mr81492905ab.4.1734283157020;
        Sun, 15 Dec 2024 09:19:17 -0800 (PST)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b2475af322sm11024845ab.4.2024.12.15.09.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 09:19:16 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844ee15d6f4so181149839f.1;
        Sun, 15 Dec 2024 09:19:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTgZWN4C9jNsp2SPWl3MWBjqM1RwyixFvnyNZfI99pH78GhTTDkkHTIyvZ51LhXoGttu6RNH8nb70=@vger.kernel.org, AJvYcCUmnl194c8/0tVUptA/suGHe3/uan83UG8nwtkNAlLi0GWaK5iLJCj2iQ6CRhR/nDJguRjLWMIX0bkeIO/9el5AMC5oHQ==@vger.kernel.org, AJvYcCUmu0DeR0tj6W1uNm15lU3pxKFRhcnfRz6SSxB7JoaHATNhbA1cb5RL3xrmsxKzhys+z7tb1n0EZG1iawRi@vger.kernel.org, AJvYcCXFD8SXP58t5udyItjLjDgLykY6nQZ1btGqKnTVbjHmKKFgqfDKCnGUXOtrLyac/J/qKHSZtpmG/hF9v4k=@vger.kernel.org
X-Received: by 2002:a05:6e02:19cf:b0:3a7:6a98:3fdf with SMTP id
 e9e14a558f8ab-3afeee7a120mr76941105ab.14.1734283156279; Sun, 15 Dec 2024
 09:19:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209163720.17597-1-josh@joshuagrisham.com>
 <797b248c-7542-43fd-8e44-f2c7d650ccff@infradead.org> <CAMF+Keb0cXc8t8J_T39WJUKydpD2EME92ZWT7SFr_taiCXfvww@mail.gmail.com>
 <90e6a8f6-666b-45cc-ae66-4ccbee0ba08e@roeck-us.net>
In-Reply-To: <90e6a8f6-666b-45cc-ae66-4ccbee0ba08e@roeck-us.net>
From: Joshua Grisham <josh@joshuagrisham.com>
Date: Sun, 15 Dec 2024 18:19:05 +0100
X-Gmail-Original-Message-ID: <CAMF+KebEX+AM_6O5j=ym6GzZ64qac=Kknd1SKLx6VhJsZG-eiQ@mail.gmail.com>
Message-ID: <CAMF+KebEX+AM_6O5j=ym6GzZ64qac=Kknd1SKLx6VhJsZG-eiQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: samsung-galaxybook: Add samsung-galaxybook driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: Joshua Grisham <josh@joshuagrisham.com>, Randy Dunlap <rdunlap@infradead.org>, 
	ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com, 
	platform-driver-x86@vger.kernel.org, corbet@lwn.net, 
	linux-doc@vger.kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Den s=C3=B6n 15 dec. 2024 kl 17:35 skrev Guenter Roeck <linux@roeck-us.net>=
:
>
> Your v2 is highly unusual. The patch description is the change log,
> and the patch itself seems to be a diff against v1. Did someone ask you
> to do that ? Just wondering.
>
> Guenter
>

Hi Guenter, here I was just following a patch guide (or at least,
attempting to?); should it instead be a whole new patch against
for-next instead of a diff from the v1 of the first patch itself?

Thank you,
Joshua

