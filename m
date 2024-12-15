Return-Path: <linux-kernel+bounces-446618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337DC9F26ED
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3B81613C4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 22:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680DA1C3BF4;
	Sun, 15 Dec 2024 22:51:29 +0000 (UTC)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC471DDD1;
	Sun, 15 Dec 2024 22:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734303089; cv=none; b=PUkYkIgLAJIDHJ4ZvetFmiEbGSvfhzAmlE/77kLVs4WSeMz0uAQ7WZTCoZMlV7uLVzVqsQuA6EvcyQWJHzbpTSAA/au3RU/+i7qOqWIqIxgVBT7+2ugoDadTiX8mHDiu6HiF7nzaWhNxvYwpfL692txBpqqCP9RZqoNb2ehMaz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734303089; c=relaxed/simple;
	bh=o6I3W7klCamFQeXkeOH5uyOGv0DvHdouvOxNptIMvpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KC2Dq+l8sUgdbQzOp0veN6OSC68zthPBk5kcwoIVhNwsDAWzG+nWMtnqHeoieqIsGqMJOd8+6y3sTMeavO21o4pq1xeG/wY16YkYO3vjBwlpt9fe7trsYLBMDGqdSW+AizSMdvL3AQAlzxi/4eDVS08W8BfByuPlPk+TFfyS3MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844e394395aso90623439f.3;
        Sun, 15 Dec 2024 14:51:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734303086; x=1734907886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ey7Z5BnWR0JgH0qrC1BqdavfXzNd9oaMn9d6y58r5Y=;
        b=I1t6597QQy2ziWF5jqmgsC18NFz/zVdEbKwmgSIbN181GVnxY7Jlcy8O7P02YAwF/q
         0Ctlr3HZ2IofY8XsZia4FyzmuxhtsulqTEC5WXDZOyHYBCXGBbl3lHDgChi639OskVMM
         dzHMD7c1ICqbgvW1UYrDIeXYTvLYm8BUozMAJbHmwwm+e3AfQssqllUExbezxtt2MxTe
         QFVuer2JYnHgbNc6sfqoXvy303ZEvwg0AdCME5IOL9zim7PDzCwlEauTzFLUTFghPwoK
         fqul4FCmWgFeVvy0S9H3fNURiOQB5VfGws79kVjl/4EpURa7fDMxlXIb54KoM6VuqmFT
         Zh5g==
X-Forwarded-Encrypted: i=1; AJvYcCUccsGj0cb92ctGEM+XNL3lUhFVc0fmXSWOl1XNTvrBBJ4svvDLjPf218XdVGEHm2IETrMsvs6jxmja1l6O@vger.kernel.org, AJvYcCVB/TyXgk1nRaCCT+wpKJhhuytSkSQ+pZwhenqVqIHZ4SiYzjZ/ZGQlKbZNHs5Hg1hEQ7MEnPXu6VM=@vger.kernel.org, AJvYcCWqbbzd7o5Xakf1dEBfcndcLjwx2/N7M5fyVws3EyLLqJ3bSHCvDTR8qJNpHuQ36Qnnrki8XoCxqBQKgGk+HrmQIy+QyQ==@vger.kernel.org, AJvYcCXl2toWtK/iBsk8Rh5GzHwE9nq90VHziBDJasrbPpWUbVvGwaNbUtVEwMGQrVEgruNSUdn80oxzvglBbmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7iCwh2xEBBpbVMugUEIJuZX7HpZ98FPkvX6nQdOCwlUoqoC8o
	frufALVkOuvuOxEqcPkB2wJK90F+UjW+H+37MSSmOmM1AHbHihTlRfq+w8/z7d4=
X-Gm-Gg: ASbGncuxGieSiOqtHC5+r7xtlFZK8zmsRc+u3fTSgRrIfzLhQ2zH71Vnp8uJbFkmDht
	TlN62MNH6au/zTCGKxKS/XgA5Gqo9Zf1Szu7lByMdgSw9qSqcUq03htXgZuy5ZLksNGIHUl0s0B
	28++4qWadQHEcNr8I9ukrPr4M8QMWa24bYpspf9fOHdIvzh41+AQT58XtngaOQ1QX/P+M9N/iI0
	gcijtjjnfJrbds8tLXAgwrixqSG2+qwx3tpks2MWJAnmoyw0km0Rw6KHUbsFtBJLjdIaMUMlirr
	s7XlMDqYzc9wMibpnv+4LT0gEw==
X-Google-Smtp-Source: AGHT+IEBtX48SXY/rYz3FGWWPa9DFrjvtj0IW9D9C8OVapFqdGb3dGAn+Y/qR890s+gGLvi6g8UJkw==
X-Received: by 2002:a05:6602:14ca:b0:835:4b2a:e52b with SMTP id ca18e2360f4ac-844e88e9c56mr1020112239f.10.1734303086442;
        Sun, 15 Dec 2024 14:51:26 -0800 (PST)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e0368817sm910292173.6.2024.12.15.14.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 14:51:26 -0800 (PST)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a8f1c97ef1so10377715ab.2;
        Sun, 15 Dec 2024 14:51:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVx05jl41k7KGKvGHt6U1CfWnNQB30+2PuXKlY3g+e2hpL19SVz44jrc0PC2HCF8ChyFA9/EAGLB9mqf0=@vger.kernel.org, AJvYcCV8h/e8CV+7mZUCuw8j+edUmz9XDnxSHadgESKo6IJhNaigr2LsebsyVGzQm+GvoconA9fxppgEUNdVZSmJ0vA2DZRpOQ==@vger.kernel.org, AJvYcCVAl7pz7JgyzjthbjTRyrGj9IYKe1ACM5iYk9UxOoj09Kcg1DXus2IJTj3F5zYm6Q/jSAgTXir9o7EhL68o@vger.kernel.org, AJvYcCXHP4KPQIcQUjg900v60tS0I4qe+QrsJm64xZnmmxAUIuCJ2RJSl89hadf4tMyP7cpBjs18bEz+S7k=@vger.kernel.org
X-Received: by 2002:a05:6e02:12e8:b0:3a7:e592:55ee with SMTP id
 e9e14a558f8ab-3aff8b9d0admr123643085ab.20.1734303085958; Sun, 15 Dec 2024
 14:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209163720.17597-1-josh@joshuagrisham.com>
 <20241215141352.58244-1-josh@joshuagrisham.com> <ad96404e-60c4-40cf-b287-f81fa85d85b7@gmx.de>
In-Reply-To: <ad96404e-60c4-40cf-b287-f81fa85d85b7@gmx.de>
From: Joshua Grisham <josh@joshuagrisham.com>
Date: Sun, 15 Dec 2024 23:51:14 +0100
X-Gmail-Original-Message-ID: <CAMF+KeaPXojdGsT1--pa+nvAsbqk6_vFnZjGW4Dcgsfr8+gHZA@mail.gmail.com>
Message-ID: <CAMF+KeaPXojdGsT1--pa+nvAsbqk6_vFnZjGW4Dcgsfr8+gHZA@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: samsung-galaxybook: Add
 samsung-galaxybook driver
To: Armin Wolf <W_Armin@gmx.de>
Cc: Joshua Grisham <josh@joshuagrisham.com>, corbet@lwn.net, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, jdelvare@suse.com, linux@roeck-us.net, 
	platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Den s=C3=B6n 15 dec. 2024 kl 21:02 skrev Armin Wolf <W_Armin@gmx.de>:
>
> The dell-wmi-ddv driver does manage his battery extension without any glo=
bal variables.
> Could it be that you confused it with another Dell driver?
>

Yes I think I was looking at another one, but have reviewed
dell-wmi-ddv and it was very similar to what I had done. I will adjust
samsung-galaxybook just a bit more so it is closer to what is already
in dell-wmi-ddv (e.g. use a normal device_attribute without the
extended var and use that with container_of to fetch my private data).
Thank you!

> Please submit this v2 patch as its own separate patch as described in
> https://docs.kernel.org/process/submitting-patches.html ("The canonical p=
atch format").
>
> If you use "git send-email", you can use the -v2 option to automatically =
adjust the patch
> header.
>
> You can describe the changes you made like this:
>
>      <commit message>
>      ...
>      Signed-off-by: Author <author@mail>
>      ---
>      V1 -> V2:
>      - <description of changes>
>      - ...
>
>      path/to/file | 5+++--
>      ...
>
> Thanks,
> Armin Wolf
>

Thank you both Armin and Guenter for highlighting this! I did in fact
use "git send-email" but did not check the contents of the patch file
(other than running the check script and resolving various issues it
reported) to ensure it looked ok -- lesson learned and I will submit a
v3 (including above-mentioned changes) of the patch shortly or
possibly tomorrow :)

Cheers!

Best regards,
Joshua

