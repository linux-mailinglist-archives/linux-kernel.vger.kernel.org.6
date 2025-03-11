Return-Path: <linux-kernel+bounces-556720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3344A5CDEC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807A81898B72
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5938F2620DD;
	Tue, 11 Mar 2025 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgNqwsxl"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A01125FA2F;
	Tue, 11 Mar 2025 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717791; cv=none; b=O7YZiS9H/fOO/CFV1R7Jl5YSCuSRZpT8jK3qGbyJt21Q4CW2Rk9wLoKZpZaSa4NIziUmjYpn/2O+y61llqP8Hvj4yH5P8b7aurcGP8e2dBz/JdlhKaEKFpe0TGt4emuGoCNuWQxPSWgbrMaEXaGEmADwlshqaMFevlM35iTL9o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717791; c=relaxed/simple;
	bh=KnUqSnd7tj6cBBg2v4+tl5NOkLLKNodYpc+Q+0LlFbQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=VnV8p7RCWbUXzWOGZex6gy9U92hth0EIBqJj7x2c80mz0pAQ35r0zFiBV1aZJ1XpGXTsB4G5GSAWiBIgBTIA2DyvRwr+WYjL+ALsbtzFt+ckcu+NyRXYBiikfs+ijyJG54GqmhmiJgFDsyKlPJQVkxOBYQLZwY83LY9PmazrWhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgNqwsxl; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e46ebe19489so4570333276.2;
        Tue, 11 Mar 2025 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741717789; x=1742322589; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnUqSnd7tj6cBBg2v4+tl5NOkLLKNodYpc+Q+0LlFbQ=;
        b=GgNqwsxls4/KXJyFyyLNI2OGvwUAg/ohRF5hhWAIamxBQqIWi0gv8QHRZ9778/emcT
         3iz8jjqX0ohEZdGuZzNcQcMdAALPSfCMcMV2n+REa1Y2LuosXA98fh3T0ZuoxMw0z+lX
         BQfee6GcXMfHk8WbdW25l8jM02TGkT7HkDxxgnzC25HrhDe1bP6bDyzyp54PhxlfsxTz
         NmfkaHLOJDQfwqqMMH7JWl3sTXHWZCTucNBlefF6fBadCq/7ZvV8a+UV6isDfCWdX4ck
         0GRIJEHkmkeb24KUd1B0MQ8GpYDiF83yC/vIUltTsNEgMEFRsiB1oV1STJr9kcqytZFv
         2tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741717789; x=1742322589;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KnUqSnd7tj6cBBg2v4+tl5NOkLLKNodYpc+Q+0LlFbQ=;
        b=np03yAzlkqC2TIskdtM9XXnJzPBb1y4xb/rmSLrI2Pd3WOGF6YhsoMZxpbsAalbb5Q
         sKyZ0kd1T6olUxqNJDh4aoHQxM4kZlfEXSgrziHJBhtphAPHKYxWo/zW/Wae4cbbeG7e
         +0RUrVe16+qXYTBSjUYl0TFEMA7/fqFDpvol241LBCR/gNoC0HeZEnmcXQfZ9/Ayr+tz
         VjoHy7JUY/jJqRrTg0jh/XhwVXQlEEDPY0WFeN8MwRLHUd0xSHMC6G26aP2Fa9xOG8Da
         Eelo4vPWSpnuZLyGJtgTgBHJGLy12mVJEUhSDdLxVZFsmqRcwLwEjZ6pa9jRK8eMgCoD
         V3jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQtO1hAunNjEdskUo69bL0udCfT90FugMi5hJjlPZrcs9lJ3IZetp88KQpRDp2xWENjqNNgm9Nwp7moCid@vger.kernel.org, AJvYcCXNy+sU/2Zvpi/eI65eqG47NsHg1tsYF82uRuPzictFIc5HGTbDlDoJIjvjWNe/m6drVM5gWZbXmZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Mr+X2TdFUWbJ6cI77WsS/jcMYKgbu3fyUzRL9LVeaskylydA
	5y/ndnXW3/W/j2PdDx1Ot78yVsbVhOC9ulmkfA7GC9DoZKrSJ7UW
X-Gm-Gg: ASbGncugOMhytbfEmsaapod70VJ0OCWMAaBXfshC5O9oStuqRMyYKzUUNcnCa+wHnde
	fWpjAtjps+ZPKvWMswRA/lEyJHkSJQ6RRaz2WMOANFWQos2Jr7EGzMpRFxIst8pW8i6NHWe2guS
	S2UdCsz9XGlkckm155WivTq6+kjxWCVn7ciD9udX4VaNnm6tMxClS+0Z+GL4aS9m/1O3pPhMTcY
	HtzLV3Mz8kVmg7ntpCXIRa0fHs69QSwGkvSxEvA+4n7Ezk5yMOd1mk8GcBzHpWMoFMhhBLu0zgg
	VKwSbU2zIVT7AfIV2RZXrqNzL8Xa6mkCDJpG
X-Google-Smtp-Source: AGHT+IEuac/DAgSbKgIDxj7RrLhtBD/FJFLHfm6z+zqKWYjZg0d+aSa9DtIpcDnkKaHLq+cQ2V/Z1Q==
X-Received: by 2002:a05:6902:2081:b0:e5a:c837:a8c7 with SMTP id 3f1490d57ef6-e635c136db5mr23807476276.11.1741717788979;
        Tue, 11 Mar 2025 11:29:48 -0700 (PDT)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e634b842945sm2792519276.20.2025.03.11.11.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 11:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Mar 2025 13:29:45 -0500
Message-Id: <D8DNFCVO68AX.NE67F0XRBQYX@gmail.com>
Subject: Re: [PATCH v1 1/1] hwmon: (dell-smm) Increment the number of fans
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Armin Wolf" <W_Armin@gmx.de>, "Guenter Roeck" <linux@roeck-us.net>
Cc: <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jean Delvare" <jdelvare@suse.com>,
 "Jonathan Corbet" <corbet@lwn.net>, =?utf-8?q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250304055249.51940-2-kuurtb@gmail.com>
 <bfb70a81-2ac1-428c-a327-d5098a8d3ce8@roeck-us.net>
 <de49b8e8-e865-445d-881f-d26a7bbcf9e0@gmx.de>
In-Reply-To: <de49b8e8-e865-445d-881f-d26a7bbcf9e0@gmx.de>

On Tue Mar 11, 2025 at 1:17 PM -05, Armin Wolf wrote:
> Am 11.03.25 um 15:13 schrieb Guenter Roeck:
>
>> On Tue, Mar 04, 2025 at 12:52:50AM -0500, Kurt Borja wrote:
>>> Some Alienware laptops that support the SMM interface, may have up to 4
>>> fans.
>>>
>>> Tested on an Alienware x15 r1.
>>>
>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> Oh, never mind, I'll apply this patch. If it causes trouble on older mac=
hines,
>> we may have to make it conditional, but that is not a reason to hold it =
up.
>>
>> Guenter
>>
> Hi,
>
> seems that i forgot about this patch, sorry. I just tested it on my Inspi=
ron 3505 (single fan)
> and everything works as expected.
>
> Thanks,
> Armin Wolf

That's good to know. Thanks a lot!

--=20
 ~ Kurt


