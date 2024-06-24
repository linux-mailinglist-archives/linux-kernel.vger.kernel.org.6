Return-Path: <linux-kernel+bounces-227598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0329153E3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ACB61C2088B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0048519DFAA;
	Mon, 24 Jun 2024 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7LLvyYX"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C688619AA7E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246781; cv=none; b=VpktMTgXg8fRZ76KOS6jsWpRI4F0DKbbW61b31tX+MIQGZk7k19+pUig80JsgmPjQAGmj6Q/+qAQz261ceOJHpEx7DJyRdjkEQmQ4KhYb9h02BO0kXiVDx9fgj44qdv0fvjZV84F5x8y69kJsLzuT7PVaAr9SFW5p3Xq907UDw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246781; c=relaxed/simple;
	bh=kmJtgTsgtZTlkCh8FeE1ujdxkosMVSUNwf8QsgGWP6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHab2Zly0lGd0BwsoebLVGpa79tWN6UOc5OqPPxskGBz1LW3kqU6qlc9404tHGlwsy6I/suOJdjHPyYGIE44hlC2FztDiQRg/VHfGR1uPUT4gEicPpZy6/nblcKvTMlmiw7v4zUE0N34VBEXVwWX2I4sNfDL8OvB10dtDM6whBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7LLvyYX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso44547a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719246778; x=1719851578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kmJtgTsgtZTlkCh8FeE1ujdxkosMVSUNwf8QsgGWP6A=;
        b=i7LLvyYXpVaeaI600pG31IuE/VzjzDy3brps2uuAuabszJ0OyQeHJw8e+Nn8miqbS9
         RkbeN5SAvZzzgTiGPBEgXRlzd+AHZGgQ/qpM7Os6w3ouP6embldKw4gkBuicHaY4qHYg
         nPx7lFpeiIh+VKwG8QhmE4k8ZBUsVCB9x7/yKgRHOPUD6Yu9n1mDlh/BUsOxbw1mPkgp
         Fn899sYkRO5o9ZPogJK0CwkZzQS96Hhjv22hDnkUmX1QrjVaWCB9Wc1ReZUzrmz6aosg
         pwb8PMQIQx/E5O1AZ8SdRzu8Ph2my5NOVwTLKw9jiBBybBf+7fHTD5haBjxHMpSYmB6u
         F3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719246778; x=1719851578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmJtgTsgtZTlkCh8FeE1ujdxkosMVSUNwf8QsgGWP6A=;
        b=ORyUlHXvlIlp1+cROO3EEyXRUu9X8TUcT/gh1evvb9qwQaPTeNLKP0PFEb5eETdba8
         BKzKYf+FzqK0VtrSNkYHtR3mf/CIPwV0+CyZYy8SZ6YT4/oH/nnc2a517D+osTRWdB6L
         U+yL2MCWg6OwbURqAWepVtej+P3+o5DUD3LASgVoWeI6OliBu6kYSD2ilaJdt/CoOYn1
         J4oIqRZroKn/lsvrcxFUgu3hzd+CxPs7hhMwxvgUxsvhzRLS2mKd38eMfGegDzbvaNAN
         R3NjFebDJLwpZrLB9I6I7aJxfB80Xy1dBJJcbSb5s0J3Pg3FICZri44yeWdYBNooNxHZ
         CZew==
X-Forwarded-Encrypted: i=1; AJvYcCXBPdqw/XkO8UqQyitb2tWUcub7Q5BlqZ5E+OrBeMIm9EPcBrCQBdwfpn6oOuxPJegWocZND6+ipeGDS8s+OAxuS69ccoX6J/qCwocs
X-Gm-Message-State: AOJu0YxyW13Mrbgzr2vr+RVbMYWSlZmLKhshnScApIxF+0+LiaEtdbVE
	zBQbbGkYdbdP0buE5BOUim5wepDeEkSWJfKKFST81NR4GrwsQEfV2uY6bw3KgHncmjQXavd3/ET
	xmOG7TRhSz9RjH10ONVgIDAjmUy6ia1KSkTpn
X-Google-Smtp-Source: AGHT+IEl5Ew5w+PWn74FGxxwXzaaD09WahDkImti/Go2baFYDXsiLn8hpTeaw26FMKmyFQ7L9WFL0AFDnp6HfsfXAqA=
X-Received: by 2002:a05:6402:2788:b0:57c:c3a7:dab6 with SMTP id
 4fb4d7f45d1cf-57d419eced6mr382420a12.3.1719246776229; Mon, 24 Jun 2024
 09:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510201244.2968152-1-jthies@google.com> <20240510201244.2968152-5-jthies@google.com>
 <21d4a05a-3f64-447a-b8e3-772b60ef8423@nvidia.com> <7b46779f-3f44-45f4-8884-2f9f625485ae@nvidia.com>
 <CAA8EJprxHq65mAU6a9iGD6Yus-VB2x3WP5Z8JWN1oUwn+zQDfg@mail.gmail.com> <bc9cd446-5e19-41c4-a316-9eb362f2d190@nvidia.com>
In-Reply-To: <bc9cd446-5e19-41c4-a316-9eb362f2d190@nvidia.com>
From: Jameson Thies <jthies@google.com>
Date: Mon, 24 Jun 2024 09:32:44 -0700
Message-ID: <CAMFSARerhgEVy4u2Guq5D_ygp5Fm4Ay6CtqjaL8iZHqJPYzD4g@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] usb: typec: ucsi: Always set number of alternate modes
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, heikki.krogerus@linux.intel.com, 
	linux-usb@vger.kernel.org, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, hdegoede@redhat.com, 
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org, 
	Benson Leung <bleung@chromium.org>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jon,
thank you for catching this. I'll post a fix to address the null
pointer dereferencing.

Thanks,
Jameson

