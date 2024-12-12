Return-Path: <linux-kernel+bounces-443561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884CA9EF7C8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4159917AF6B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26560216E14;
	Thu, 12 Dec 2024 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="vr6JOzmC"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5FD176AA1
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024151; cv=none; b=HVK9k2txdOpwySDS0HuWYld0khN0JmkaIA4yTu/fbG4B0CgfNK8IhXbAcGFog/LVqsJ6ImqiZsHJz4rKYtZXQ2cq4Ik/LiuE8oCFSw3zh2G3OHVIsWY7TOWUbaBvysE4dXR9Jy8DrTzTrSG9InyHXSqOFrZMv1iXMJi0qWozeu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024151; c=relaxed/simple;
	bh=ItVZ115MBy00UtnwKK7ISqvPf5/M4tPNwbj4rk9A9Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaLGFUXtEMu7RaKUdNNoy+b5S4503/GVLcBZHRuGw5PotH6kZv0MpHbN0k7PdUCxiq2N/FMN/3dLMEmFAsZ9QUrxs60AU+Hx2jBcH8EUn/lFVqufpzcWEUhzBcjmWUf0ZATF9URaLNREf7+45jWylBDhwb10zkMAj4ldPZ0G3jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=vr6JOzmC; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-467a17055e6so3714301cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1734024147; x=1734628947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ItVZ115MBy00UtnwKK7ISqvPf5/M4tPNwbj4rk9A9Wk=;
        b=vr6JOzmC70tmDyDCAfzmdvTvhtB2LZmE6VCLikb2AXieVkSsSUHOrfULe6oQnGmDEx
         NpwfIu5evzsm8WEM9On4LGPPc2Mxq+FXC0t3fVfd0Z2zVb1Yn2YLwrDmltLUUZKBEduJ
         RzgJGbsSrMEJXH2GzNuXXc6351HWeQoHXn4Paor/JbMbjMYiKcT/DzoS5YW6+cDdBGqN
         9Ryx1U7as4I5/RkPxozM0C7QPa4OLbwLwf4bHja4AF9MmM7JGBd/SgifnWB+woWw6gQT
         PqUyB+1JH7r4pqOzS1frJQGsm7vj8lBXrSNhxAY/XSXRP0btgs3IbdxRr9J5YXVTIzrf
         cblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734024147; x=1734628947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItVZ115MBy00UtnwKK7ISqvPf5/M4tPNwbj4rk9A9Wk=;
        b=WXp18fO27f7sWBmhkCeacZxGwtttdqygtnUebiq+M7Ku7dtujR0cGFmHqGQtwdUWbu
         xHRa2WzfQdksMwYHLL4wsr1k9nWxiM7yzCeZnEllJGLUbXP9qAHl/0xvf8BF6d+GcCrs
         qN70sq8AH0zIllTqvGVjYR6ImffbJH23s0A+A8SSnoAqwIsxrTyoLUfg/HhNXaZPdMqZ
         aYtutaylaFVretPfbIatxm/3LcdxgdmUj+UCxBD/F4eX+IHjXy6N0M2CPfF6C9f8VRY8
         XfVbpZ+PZWyXjewSvQUkG7Lnggn/kGEdT7Z3/HKyFCMDTgDObBHZTj3lUS4mIUWfTQXH
         NOjw==
X-Forwarded-Encrypted: i=1; AJvYcCW17SffN/h64LmPh4lucOMMzmenQI4eC76ply8nwpBtfaVfsQeD8buJHTqNyXvTLZrOYpWATXFNdsdJb18=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzeTGX7zfZA+xW7v1yVKq9n+bVtVkRpAGd9CyAbtG8YwoIQHQ4
	A8+wgyL3HOyjFJh4rWMt+JTbq2gfkRzZ7diMQFawogF4In0ofbEJgaPk3WGqb0A=
X-Gm-Gg: ASbGncs8/O8DddC241Jm2l6hJj4yfSBgWVqXHVJ+gMdkI8RiOtqKkHZ3Wdt4Jv84L3t
	8oFGiVD+oE/3BsbPRfK3fIEQoBFtOV9K0f6RiGShp/ctiHEWzd2b17UQX86znb+/dpVvTj451PW
	nUPjvkrNcQUtg7T73m5VRm2JSVkR2z6EdnAS3B62D1H2/YS6nMMccy3TlBxrddaJgMC/x+w79D8
	SrrRpgZks4xPHkjcAQYh/TYpSda0zjEsXUKK3ZA79IO8ITmhOxg3eI=
X-Google-Smtp-Source: AGHT+IFwlTozGuchS7xOSbyLPAV7MX4qrVeVLcoFK+ZdGoUf0iC8iJIQmZdAV5+VIAr1Q+4xDj16IA==
X-Received: by 2002:a05:6214:b69:b0:6d8:a148:9ac9 with SMTP id 6a1803df08f44-6db0f80e72cmr14012946d6.30.1734024147597;
        Thu, 12 Dec 2024 09:22:27 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:97cf:7b55:44af:acd6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da9feab9sm83721546d6.71.2024.12.12.09.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 09:22:26 -0800 (PST)
Date: Thu, 12 Dec 2024 09:22:18 -0800
From: Johannes Weiner <hannes@cmpxchg.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: david@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
	riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
	yuzhao@google.com, npache@redhat.com, baohua@kernel.org,
	ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
	cerasuolodomenico@gmail.com, ryncsn@gmail.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: convert partially_mapped set/clear operations to be
 atomic
Message-ID: <20241212172218.GA19302@cmpxchg.org>
References: <20241212135447.3530047-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212135447.3530047-1-usamaarif642@gmail.com>

On Thu, Dec 12, 2024 at 01:54:47PM +0000, Usama Arif wrote:
> Other page flags in the 2nd page, like PG_hwpoison and
> PG_anon_exclusive can get modified concurrently. Hence,
> partially_mapped flags need to be changed atomically.

Can you please include a description of possible consequences if this
happens? I realize this was spotted through review, but it's still
important to break down how this might impact users.

> Fixes: 8422acdc97ed ("mm: introduce a pageflag for partially mapped folios")

This is in an alreaady released kernel. Do we need this:

Cc: stable@vger.kernel.org

> Reported-by: David Hildenbrand <david@redhat.com>

Link: https://lore.kernel.org/all/e53b04ad-1827-43a2-a1ab-864c7efecf6e@redhat.com/

> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

