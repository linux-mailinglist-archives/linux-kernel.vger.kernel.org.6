Return-Path: <linux-kernel+bounces-191449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA038D0F69
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7140A281AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576E216191E;
	Mon, 27 May 2024 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="k5YTyz0T"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB6353389
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716845247; cv=none; b=E43otfSvdQtt5LBbq12VBdtaJnGfjrK1kb2ZkPGIvStwOHjcStzM6oa8DSrkB5yO6UqZj4Hg0z4A9KRj/GSzlI7V/9xoLij8kpc5Szfyvemcq7xAM2pEz0PnmUaIQsJD/17y4yzmHanfjh2rs51rHAVEdANx2/MBiIW5WFobZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716845247; c=relaxed/simple;
	bh=JQSgT4mCqW8FyQBXigrHwRZA1y9FMk1aW742MZrqNpk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rimF2e0J1+SfbgEW2FtPXW1X8TssReMW1j2kyxkPLc9mKAtl0tZPJUJRhW6Y2pHYNJpdxjtx6aUNqJbkPJEb1drSRHZ3kbqfBikHYB+Hn2U7r9qn6PurTSAdGVU+nrNH3XzbPZDUnzoELh3R6AbQrJi86I92zDTM7a9h1uLR7F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=k5YTyz0T; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57863e2846aso118956a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716845244; x=1717450044; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQSgT4mCqW8FyQBXigrHwRZA1y9FMk1aW742MZrqNpk=;
        b=k5YTyz0Ts+T/LLPZtM95t2EaBrQH8RCdZ5jrAbL85mxvzgSxk1FFGtZ+PGidjZl1af
         yF4e5frvXMjR7sUnBZX78vLGRYd1EcfP1YZPW3J/6P6p1TDcInZX3MJZkitPi7P7iVEL
         62qbY8/9B47Mw24WECFFkZxARIw8FhGgcVIYshCq6pVGnlVEG7WbC09MKwsFFvnQTvLN
         l472aktM2N30DXNBEqInBF6den468ngXO2rnAdQZzqGuYU9B1JLz1ZgW5Ma1GN7k2dSH
         YvbTNZAIVWONw4c75NeA7Shm4GpnJg5uK24A01Vmd8zxFZHghqui7bM1j5GgbE0HptmT
         SVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716845244; x=1717450044;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQSgT4mCqW8FyQBXigrHwRZA1y9FMk1aW742MZrqNpk=;
        b=uszFGBIQtn9+uDTmWm2NYzZ/NPLwrCqJXTtRA3T3Iad2agm4Sf4opEaYIgnmfNJPjF
         pLmcQbmP7IVFH+YOGG39IFr6VwgZ0r01RG6gBTmv2znA5qaUukxTCw37ta2JEHw6UfbP
         UhqXbU+KL9vB6ntPAojRvLHZ47nHceCqRqUFVxw/NVbnoTCnZsnl/R8l5gDWOklqTCEb
         wjtjLkEDvJATd6rtW25IGoaSndFjf1jG9TtH2GYIA5allTZf98NqAhbdanLpX/mhaqkS
         jk4DM8jHv6ceIemFBXYPSvtONbD0zPRYZFUi3AR8fEl7bbxdCem238g+rKx10UG0RjuY
         tHzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlV8sE+hkeviND/fpP2An20Prnu7K2F694BHp7kwJwECqven88IEU8geOHxzbftE2uo+Y9VVvqTnPXBSpYBH9yeK0sOkrkAtlXuP00
X-Gm-Message-State: AOJu0YxuEKqPq1n5oZIfXcBKIaRzM4kyCdZ0irLt6FtvKIgvcbYTFt0K
	kZDisbYnrcMI2EOT7Ir1eC6FtvikapNPR14q2W7DA3Dm6zBMDkQaQ6redEkBebs=
X-Google-Smtp-Source: AGHT+IELOyKcMnwR7BVbM+SlF9SzQjptqkXxQf1KRkjjcSj4V201MJmZJSjDNl+kfWgXY+nUBqF87Q==
X-Received: by 2002:a50:d593:0:b0:578:5f1b:5018 with SMTP id 4fb4d7f45d1cf-5785f1b50f6mr6076394a12.29.1716845244443;
        Mon, 27 May 2024 14:27:24 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:aa3:5c01:2d16:b332:5fba:374e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579ced17435sm2478923a12.53.2024.05.27.14.27.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2024 14:27:24 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH net] docs: netdev: Fix typo in Signed-off-by tag
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <d0af9c38-d15d-4706-943a-b0b68d1eacea@lunn.ch>
Date: Mon, 27 May 2024 23:27:12 +0200
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 netdev@vger.kernel.org,
 workflows@vger.kernel.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A1AEC97F-AE56-44B4-8198-E86F73E1D0F6@toblux.com>
References: <20240527103618.265801-2-thorsten.blum@toblux.com>
 <d0af9c38-d15d-4706-943a-b0b68d1eacea@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3774.600.62)

On 27. May 2024, at 21:12, Andrew Lunn <andrew@lunn.ch> wrote:
> On Mon, May 27, 2024 at 12:36:19PM +0200, Thorsten Blum wrote:
>> s/of/off/
>>=20
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>=20
> Good catch.
>=20
> Please could you add a Fixes: tag. And a Cc: stable tag. The file you
> are patching discusses all this :-)

Should I resend the patch or can I just add the tags here?

Cc: <stable@vger.kernel.org>
Fixes: e110ba659271 ("docs: netdev: add note about Changes Requested and =
revising commit messages")

Thanks,
Thorsten=

