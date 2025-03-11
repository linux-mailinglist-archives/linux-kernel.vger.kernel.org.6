Return-Path: <linux-kernel+bounces-556304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ADAA5C3D1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8F8F3A5D62
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F76825A65A;
	Tue, 11 Mar 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OriaTBmT"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585D84D2B;
	Tue, 11 Mar 2025 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703493; cv=none; b=iXRPmBoVzgnHLRzsaEPpAH6S2s1oIyNFpw+TrqO2xaL7CN+467q29eLLMzk1cDR8FMh6qjBLQCt2wmvPUX6SzOXW8n1/WBhM1Czhhf/87WhsMkBASbRtWuesS7RzN5oZlqgDgZ0gt7m7mHOZWMUL/Rm9DyuypeB+BhiYjzgTb9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703493; c=relaxed/simple;
	bh=MwX+hLj+eMLpZm23lEQkZzA3/IGcokUB7SIroirMLmY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Zjr8u9pKsO78nAlbIJllrrc9cNLHH+TX9w+nXy4nGQf+y5DTLn7HXtxO17dRZOlzJn5eTbdyaXG8feGJD0znLvklBU5VoPKaMP9i2QLy5GuoKp7QWpjplSf3R0mGtgSZLi/vzphiwB4pvcxVis61KPQo+QHn5G8Na14dJeKuD64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OriaTBmT; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ff1814102aso1190217b3.1;
        Tue, 11 Mar 2025 07:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741703491; x=1742308291; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwX+hLj+eMLpZm23lEQkZzA3/IGcokUB7SIroirMLmY=;
        b=OriaTBmTvYoKQy0yrUcPLJW+QkZM0A75vA1kqRqcQ4eWZxjA4N7+cOMh/vcSqB2dsp
         ho2+eANm51G9IWI5ASMNVXJPVzq/sD9i4LKbwN19CUxffV5G11loa7yAdsH5LbxpAEen
         hL7jd76k1UACGqEPyOn6HFJ+UMybB2Xs/AB3dUU5CZ3er81WgKj7D/KFycrZLZrRE/Cu
         8XvRvqvIHhHQ5BcbnW5QbYK+uysBdomqwFTJxvGPKaUXy+CYtMsWacKP7EVe7tvo0wSi
         um6nghA9RAfFyHg/l7Xp0H6bTG3cCdbF+EKQMyKMVfa/bKwjZIh6yp8Na4Sqe+vT4l3Y
         rBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741703491; x=1742308291;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MwX+hLj+eMLpZm23lEQkZzA3/IGcokUB7SIroirMLmY=;
        b=cycPqqNCzY0DavnVzp9KRvzjBONFllU72/5sVq5uivJmSlP0RXBcqAf+dVeJn3DxIk
         AOWmF2niy8gjw2ifPvvoWTrZ7c/4QYmk312aj+23fI3iEjw0KmgWpGsARNtwgHrVDTbc
         Ybtyy3wqR/cCwj1TezApEF4UGbRQWm+s6Vzp3nApaGTOnp3oqhgoR016u0vVcE/X6B+U
         twB+eCVDh79FT38qy7CmAc9OfSOFDl513YCgN/ppmslkHGn2lfSBWajwXzjbFKuF4ho3
         edxVuBS6E7xi6CBQd0tApn9633N89tY7pbJtee1MJH9AWgsMIsJ6HjZrXoNOlirAmUhW
         T8OA==
X-Forwarded-Encrypted: i=1; AJvYcCVEzTzOcll/+A2dQ34ke/CbXjJDIrCcGas09Vo/eBWo9GHNF8JtJoTNKCXOpAZkqKTD0o3lCVE+mcc=@vger.kernel.org, AJvYcCWLOkgOrdr0RYTV+FBhj7H+K+GyIm+xyNTSolYS1BLLCuAy+w1cicV+/TdtVE6navvMHLI3Wd4QnK/I9J2M@vger.kernel.org
X-Gm-Message-State: AOJu0YzkeHHh4Yx/XYfAmtb6XXj8Fv4Vpg3EwjFtXf7t2omz+7cRdPMc
	Wxb3PmV8Us/rdXgJCXCJ93Y/e5HU7zoBFNB7PfI0DO+GqW5pTVfg5+bbvRKA
X-Gm-Gg: ASbGnctl9ZeKNPTgowdmok7dCm35r/NPxwbRK/+rQlRfPct7dsjEM4H4kl3KKW7ntWA
	SSpdD9+N+OMoGcdiF3oGRz1XSz847jNZHG5lMwgsPDQ6BR76gE+Gf8ug6giX78BWEh7XM1yZVHL
	pZx4Z1IdU50WB0UdRZLDH3XI6BFl0jxTrEud4CWuUksvO80/wjyi43waB1arKdW1+X0/8ruJ1f5
	X5+AyHvThWMXJqikopBc///N6TUKN054AcKRT18kmVUJoF59F0i95mU0Oe4Xodf/aZPZXYH1s7V
	mZLHZ9z/g2KJPhtAdeaqqZVWvQRVxITNyzbu1tZkgTNZkrM=
X-Google-Smtp-Source: AGHT+IHXo+gvCNYGwhhU02hRiXRZX+gNdRnjc2unpyj5Akje5bMKFUZmi5UTG9Ks/gqPNNuQoFj0uQ==
X-Received: by 2002:a05:6902:4893:b0:e63:6b50:5cdf with SMTP id 3f1490d57ef6-e63b5181cf8mr4640025276.9.1741703491426;
        Tue, 11 Mar 2025 07:31:31 -0700 (PDT)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e634b8ff7a6sm2719087276.57.2025.03.11.07.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 07:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Mar 2025 09:31:29 -0500
Message-Id: <D8DICX20T6AI.3CFMJMR1W0SGF@gmail.com>
Cc: <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jean Delvare" <jdelvare@suse.com>,
 "Jonathan Corbet" <corbet@lwn.net>, =?utf-8?q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>
Subject: Re: [PATCH v1 1/1] hwmon: (dell-smm) Increment the number of fans
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Guenter Roeck" <linux@roeck-us.net>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250304055249.51940-2-kuurtb@gmail.com>
 <bfb70a81-2ac1-428c-a327-d5098a8d3ce8@roeck-us.net>
In-Reply-To: <bfb70a81-2ac1-428c-a327-d5098a8d3ce8@roeck-us.net>

Hi Guenter,

On Tue Mar 11, 2025 at 9:13 AM -05, Guenter Roeck wrote:
> On Tue, Mar 04, 2025 at 12:52:50AM -0500, Kurt Borja wrote:
>> Some Alienware laptops that support the SMM interface, may have up to 4
>> fans.
>>=20
>> Tested on an Alienware x15 r1.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>
> Oh, never mind, I'll apply this patch. If it causes trouble on older mach=
ines,
> we may have to make it conditional, but that is not a reason to hold it u=
p.=20
>
> Guenter

Thank you!

AFAIK most systems have < 2 fans, so this driver already probes fans
until failure for these systems.

If I get notified about problems, I'll amend it with a quirk approach.

--=20
 ~ Kurt


