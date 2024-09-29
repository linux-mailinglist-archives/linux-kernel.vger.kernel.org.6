Return-Path: <linux-kernel+bounces-343146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E81698973D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 22:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D842823CA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 20:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F847D3F4;
	Sun, 29 Sep 2024 20:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="E6VjVR2d"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCBC18EAB;
	Sun, 29 Sep 2024 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727640924; cv=none; b=kQCBdZ8wU9iJTYEcB5jS1QKrV0rRUPNVHd+VPgKOVDJqGOvaq9dVL4AP+r/BHUCaNt7E502v4TZfAC0QloxC3i1dLm+74tZzPj/RKuhhfErPi5igzB4mP5wW82BzO1TNaszeKLiVdJsct7+cBkuuUPz4KY2M7nhMPzQDFBFMWt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727640924; c=relaxed/simple;
	bh=C6kbsHnZY4CHEkdYNOnQMnvz2R2muXrc7EV2uQlZEKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txxdQr9kVovBcMEMn6gr+vxfJbwYG8MwKtz/V5X37FavizyROsHBUsDNub/BWzriHz+OBFxXuiRfgwA3Tf9PuFsigda4nMTc2wGy3yaYrQ53SWUDhhWhe9bZjgZ5LP7atOHBEW5dbHVmolcCxVlpHqe4hOFNZKwAZPR8WCGERus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=E6VjVR2d; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b90ab6c19so47185ad.0;
        Sun, 29 Sep 2024 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1727640922; x=1728245722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6kbsHnZY4CHEkdYNOnQMnvz2R2muXrc7EV2uQlZEKU=;
        b=E6VjVR2dntbvnW9hBItPS453aodC9/WpfoNR/iOrpmeoNyz7fvCy19ZUgs/TTz445A
         TGnuomnaamiEF2ps0OUVkTHS0lJjbqRJJMTItHJeRodQdu8a4idh08DDHAFf2cEyH9pz
         73wE6XDBtT1LxxVKOvZKbthf56d4SrqQrVLgs6fwTHo6mO+Ekodipctn4fSyN+2fEkdv
         nkc0E3SEM8xhKHuiKc1MvVoJBptRFzV5qOMI4NVOwBBpfVtWBH6VURwPTsI0e7wSYKST
         5zyV7wAj0ZDqFm7Kt/RiNJZZ9ApXtuKg46nppHkcSP2GfK+dv9L9cI4OAU+dGCO2pjH5
         xQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727640922; x=1728245722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6kbsHnZY4CHEkdYNOnQMnvz2R2muXrc7EV2uQlZEKU=;
        b=RbFTcqOqhkMvQMC8YK7YG2EC/BPo/C1YpY4AwhYV6cLE9C9mp1H898yIR/6WtPBIpb
         MNFqtX9XPg/mfGSnFANhqcnaUYJeAJ3san8kAGM2nzlnLUig4JCN2PJ5vUAFNj1zx4+j
         I9NtySEBdU3L+gNQsMUk+YjfQmtj1YBJ5jJKx1cu1AvjtDoozSEY8Vj8PpppsC3T12Ky
         z4AN8RkF1hx8c7Wldtg+WuEcLUoQp6PuISKCAj+2SExrNLzbrvVLgJOhANAYqJ46eNHm
         lpw5V6IWnzzoUWa0aFS3XtZW7+rbA/6e8tomLd3jizPLCkV8s1OeWh4iuBUaE9J7cJ/D
         UN0g==
X-Forwarded-Encrypted: i=1; AJvYcCV8t2tdBPotCgpbKNBzpDyPk+DqunegkzKh3Jdew2LA0St+pqQbTGA5R4J6/Mdry5CoAe7WahWN3Utv@vger.kernel.org, AJvYcCW4+tz5WMnzk3CB7OfiS9wg+Dn+ccK18IoYcT3NRiMAwZ7lyvNk20pf8+0nVvN1IOalMdwekCj9obEselUG@vger.kernel.org
X-Gm-Message-State: AOJu0YwPdCQFGfceHqGK8Ae1gWnWnuWvKs2myaHCR7o5BXODL4ElEtzD
	N+uAknxnsWUZll/g9FtEt7LydT5ZwbMd0OcV4YJQlWyq2YC6s5JU1qYWy9+iG2b4retTwkrD5tR
	PzQ/pfs5l8daNAS5jGhH/ObGYM6m7Az+k
X-Google-Smtp-Source: AGHT+IH/k+F2RucCpezXya0CJVr6faMMNWovPjHyE80pA0LQItiWE2pGV1jIRx784LXOFZjCOD5KIRit1rE21uwu1Jo=
X-Received: by 2002:a17:902:d484:b0:207:5d33:a1b8 with SMTP id
 d9443c01a7336-20b37b79d4bmr147881915ad.38.1727640922480; Sun, 29 Sep 2024
 13:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
 <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-6-0b20ed4f0571@linaro.org>
In-Reply-To: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-6-0b20ed4f0571@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 29 Sep 2024 22:15:11 +0200
Message-ID: <CAFBinCBRcNCOjBH6wfv+OqUf0aNtymxwUL2O_swWXKdF1F3NnA@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] ARM: dts: amlogic: fix /memory node name
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 10:08=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Use proper address in /memory node name, fixing:
> /: memory: False schema does not allow {'device_type': ['memory'], 'reg':=
 [[1073741824, 2147483648]]}
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
as well as:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> # Odroi=
d-C1

