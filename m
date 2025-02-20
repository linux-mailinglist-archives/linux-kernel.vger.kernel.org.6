Return-Path: <linux-kernel+bounces-524175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC643A3E011
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535F218992EA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FB2202C36;
	Thu, 20 Feb 2025 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzCaAAfG"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B591FAC5F;
	Thu, 20 Feb 2025 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068010; cv=none; b=usTgQOq9RPT++cOuOPbwXcMVmQGyLnrpbItUTrbvdVAjFaGVZm2ZBdfe5hY+CE2bi6xeaQuiOOyRFcHy+MDJlAbHzoxtYL0HS27uvQh7E3KBZ0dEsxxRClOdQ+yT64AThymnf9umhGUuZVf1Om7Ubo+zr+1kQOQ9gu92lILF+k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068010; c=relaxed/simple;
	bh=+eN6d/gwmzthWaj3PJG4Q5vXE7wNTtxP1spv+1Zf4QA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=i0/aQ/rwMLjjMhsVmCqWXjxJ4WGGGKOXH9Tl4vb9oyNz9JGYZaTINkLdh1rHs5MFVnuRlR487XHbpbHVo5cOAU9UoGQWxMOKyuBXwsqBq2vm+WvM+0PUhQ2qfmlVkOnMXnsPKRbiHkcwGH43pyOhH5Rjx9dCs9JvP+IM6K/U0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzCaAAfG; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e5dd697475dso904503276.3;
        Thu, 20 Feb 2025 08:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740068007; x=1740672807; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eN6d/gwmzthWaj3PJG4Q5vXE7wNTtxP1spv+1Zf4QA=;
        b=mzCaAAfGqZkl0U2JnKNS5VP741jsimJidIGzOdeuTfchckAY532lEOWHqTTF+oOfX5
         xg7+GUBvRnDtJPWGTGaFwKTHMpx+QxekA1+I7Ysc1q273xx6MAcfqmwcXcBwhP83ebXj
         qn1Z1ZAWrgw6+VeQUAhP1i8DoB5yJbif/xvWX7h7zLq6GSgXB8O3m76Hfk+AwHacjYiE
         6lZq+N3puOLtIXOoB9O937QZyJNt8y/FdqKzK4jAAcIcgSLg6S9LWzDbdICiQavNG7x6
         tCoKNOuIdQsA0k8AWTdLZvUHbDYmkQAf/HOKqpvTih3yun9uUCn6QmYbLefvSS1/F8VU
         /KmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068007; x=1740672807;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+eN6d/gwmzthWaj3PJG4Q5vXE7wNTtxP1spv+1Zf4QA=;
        b=Klhww+dXuIJWoZZSRVOzcRye+lZsNnViWrJ8jf1C9ZPLFV8tmOIT+GQ019BuDtWEN3
         V58dzJ0Ba8HgS4WJfZOVBtsjN3fMHNpoN7ODIurDbYqV7q39q89P5iYQfiWL90kEJum0
         BDj5nK/SDpETL2hEe6Izd+tjHlbhxuzn2bkork0GPG42Jr3zo3NGjFoqRmai6lqe18J0
         dV16f4lLnyre+X8aSs9PRNBWAMxz97nToMbfd+rmEJnbRCMRr0xlKNtb4TM5VgVdjJFL
         KHQupSDOtVqm1vcftIslH4hRhCy7KC5rL1/VqubB5FlmkSGQf3KsqGwBbu9KVDKiy5Zq
         01og==
X-Forwarded-Encrypted: i=1; AJvYcCVPQaLMvX447nkCoKHQMiZq09t36IHAdWPQdBTrrJpaJpr3oDiodMLhAA76okotA3xtJ7VcDE9I7P8clSQ=@vger.kernel.org, AJvYcCWSlttKE0uRAHQ1ZVywq6UU8O3ublBfn3MEyEFLNEZe2A/u6M9o5UiRi+dqGYYoVPnmr8GzUYZwIxU5P8wUABN6gM8/MA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8js+B/F0DlXTFzbcnLbdJMzT9sb6MjR40LjjWXU3YVndWJRwV
	gQf3WnX5JbQ0NsWSwR6YqECieFqzhadE4pejB5Gf9JYQ+3zipDIr
X-Gm-Gg: ASbGncudbBtiWaCw9v1+xzwS8plt+4Fs6ujgFmdPI+aAfq7KM6uvnUfNdWNtDe8AqAX
	RKW/cO5G2vMjwhg43hddzZrzCJahaPgAYDfjWxEOA6roavPZEfi3APs5enPW16R/cXrKlLhTsyG
	WpUkrXvvOZ1jxDFJ9jKFzvW8SIZf6U06Gk+bOU9jwLMZNvXjIP16Qv5M1Vmk992/+qblq36QzA3
	QpS91AI6rxcHdUA11N0JZS4IGdGczjWk37U9BKKfI11zWTz194Qs4jtAvotEMTahzHQO//Gczj9
	+cdThXE=
X-Google-Smtp-Source: AGHT+IGSVM/i2hChDhGyNgXI3GIH42R844Aoshhfyxgttqai26nz2LXkoqtKiP8ZMRon2xnaZUFyBQ==
X-Received: by 2002:a05:690c:4485:b0:6f9:7fae:495a with SMTP id 00721157ae682-6fb5837e996mr200044437b3.35.1740068007485;
        Thu, 20 Feb 2025 08:13:27 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb9b56e565sm12735247b3.33.2025.02.20.08.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Feb 2025 11:13:25 -0500
Message-Id: <D7XEMM16VWRF.319M6S1VD7L17@gmail.com>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Hans de Goede" <hdegoede@redhat.com>, "Mario Limonciello"
 <mario.limonciello@amd.com>, "Prasanth Ksr" <prasanth.ksr@dell.com>,
 <Dell.Client.Kernel@dell.com>
Subject: Re: [PATCH 1/4] platform/x86: dell: dell-wmi-sysman: Use *-y
 instead of *-objs in Makefile
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250218194113.26589-1-kuurtb@gmail.com>
 <20250218194113.26589-2-kuurtb@gmail.com>
 <Z7XsJMwFhZLk-0S4@smile.fi.intel.com>
In-Reply-To: <Z7XsJMwFhZLk-0S4@smile.fi.intel.com>

On Wed Feb 19, 2025 at 9:35 AM -05, Andy Shevchenko wrote:
> On Tue, Feb 18, 2025 at 02:41:08PM -0500, Kurt Borja wrote:
>> The `objs` suffix is reserved for user-space tools. Use the `y` suffix
>> instead, which is usually used for kernel drivers.
>
> I haven't received a cover letter. Please, make sure when you send a vers=
ion of
> the few patches under the same thread you add a cover letter. You may con=
sider
> using my "smart" (not really) script [1] to send patch series to LKML.

Hi Andy,

Yes, I messed up the Cc list.

>
> [1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintaine=
r.sh

Thank you very much!! I'm using that from now on :)

--=20
 ~ Kurt

