Return-Path: <linux-kernel+bounces-516019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CA5A36C10
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 05:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E50A1895E16
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 04:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E88015A850;
	Sat, 15 Feb 2025 04:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DGNF3scO"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701A91624F2
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 04:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739595255; cv=none; b=XxlEvmtliatZX2mcvq+Hoe1xSlq+XO9eBJostMKYVZ1CUNDwrB0wnzkSATq4AEyTJG4/ip/9dHznsLTZ0yPgTi3z+CHeHFUuwQ6mHTWQrmg9c9F1TqcumbMLRRVh/F1vITAtZ/bs7QXfWWrxKWFgdJNYk0csOgkwTzlThmB/Ab4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739595255; c=relaxed/simple;
	bh=Qd+3HqLIBmzspnj051AjsoWB0jQ1fLQfmy2L2Kb+xZ0=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRnhYb6LmBDLmP1q4EbTQmlWmCB3tihkNsvOyTuA9f1sx8vSbR9ptMxxnWPRQEYDg6LVFD+CqwJenEp5PJV9OoINt2oEejJqL31KOTvMETOe8Er31pKqHXeIYlcdUot+DKCKWRbW48lAbqtampl7PUMApvUhvG6UIuYYQ+PpaFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DGNF3scO; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dd15d03eacso26612206d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 20:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739595252; x=1740200052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xk5ud9oKcdPfSa08b0yRfW7p4KmWGP1BqSd4dcIlPyY=;
        b=DGNF3scOsOiSGIfblQujujVvl9SAKWxkYh7Ey9iSrHzLbZnUoOMxC0vnuMZEgIC3fe
         vg3KYHfISFjKYGyUreKJcgi5FJwAT7VdsGWRqN1bmFapVunjLy+/t2OpTrH6iNGQRhlQ
         dJtmKbF0rdxpOnc0qGL1EG5clhwhSm9FPpX3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739595252; x=1740200052;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xk5ud9oKcdPfSa08b0yRfW7p4KmWGP1BqSd4dcIlPyY=;
        b=Roo6lwcRP/ytmwrFw0q7UTR6pOo0QF4DjUYfe101NB5AaCE+xJz1L/njtIsnW7PP52
         wYsG/Yw7gjM+YEd6TmjzZqdkFvF6PqUMVsFoOh5wevsWpOaPXVmVRZqvHiX7s4/c8z+v
         g7aLG3Al2Vy2kvNKeP8+5trHN3Skm1kpixBT0iKSgVVrJaHnKHwGXsgD3dAJ3+PF3imy
         benl+aoTngydWu9Xt7s9d1buUsAlGr/CgjGtLqoB6c4+WwOkN8Y13qOGUJL1NQzxBRUe
         pTLKj9rRxLku+mpDfNrsuzlGeXGFllq41N2CRro3xBBlZL5i3GxuHk12U8uvO09IjQqM
         7z/A==
X-Forwarded-Encrypted: i=1; AJvYcCV9JVUshxFKtPwrCKvmtDOhid3C90XaA2/3hcWyT9xtf8x0OojqOvFX3qBinbKAtLGX15W5uBz4DyHlJTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz5BSWqFqvGP6Dev1d/yllI40sngHthFAL54cFkumI9UGAVljk
	S13eABhcxf1NvNrFHn+7xtyj/nFzejoSA3FTCAfJHo5qsvCw8xzJWPMO56mwb1v0EWcd0u4FpGi
	vcCcK5wnFOiQvc9RpEEr2Tv+LKhyIZb+3ekzp
X-Gm-Gg: ASbGncswLaIVOH2OrgAtKBY8j9VT/ZCcqXqT66W888x6q+6Qezk83ztMVd9NQo3j9rQ
	9xqieHfV1Du84b7FI+XNFWJBWdJq2qmUt3Jx6qYAsHCzJ2xFhD8XXAMAbQfdcc7VNLYpq5f+qrP
	jpMWRrWafowbrvlk1a72rgap2V
X-Google-Smtp-Source: AGHT+IGzK9Xw2SmDlUW8aMokwQq0lVBTGu1ZfRfxjaN3RAOn85fLCKnVOv/nBSKRqAiwjG3tNqoev++XhSLCxsebavE=
X-Received: by 2002:a05:6214:d09:b0:6e2:49eb:fb7 with SMTP id
 6a1803df08f44-6e65c8c0796mr145135586d6.3.1739595252358; Fri, 14 Feb 2025
 20:54:12 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Feb 2025 20:54:11 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Feb 2025 20:54:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250213-amigurumi-shrew-of-grandeur-bb1a13@krzk-bin>
References: <20250210225714.1073618-1-swboyd@chromium.org> <20250210225714.1073618-2-swboyd@chromium.org>
 <20250213-amigurumi-shrew-of-grandeur-bb1a13@krzk-bin>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Fri, 14 Feb 2025 20:54:11 -0800
X-Gm-Features: AWEUYZm38Pxk6_mjiF-w5FYKquBrOAN7Cotkk66MVQ85J6cLXb_xLqE4js1sOZU
Message-ID: <CAE-0n53Q=HFtZqgTNN2iq-XEaedr2zMJ63=k5+Rn3PsOf69fiQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: Add binding for ChromeOS Pogo
 pin keyboard connector
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	patches@lists.linux.dev, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Benson Leung <bleung@chromium.org>, devicetree@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Pin-yen Lin <treapking@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Krzysztof Kozlowski (2025-02-13 00:11:25)
> On Mon, Feb 10, 2025 at 02:57:11PM -0800, Stephen Boyd wrote:
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +  port:
> > +    $ref: /schemas/graph.yaml#/properties/port
> > +    description: Connection to USB2 port providing USB HS signals
> > +    required:
> > +      - endpoint
> > +
> > +patternProperties:
> > +  "^keyboard@[0-9a-f]{1,2}$":
>
> What does the unit address represent here? Why this isn't just
> "keyboard"? One connector usually has only one keyboard, right?

Yes one connector has one keyboard.

>
> Maybe it is only to fulfill the usb-device schema? The reg is there to
> represent USB hub or controller port, which is not true here.

Right, this is to fulfill the schema. These pins are connected to a USB
hub or controller port, so we use that as the unit address.

>
> I don't have any idea how to solve it. I assume you need the keyboard
> child, right?

Yes we need the keyboard child so that we can make sure the keyboard
that's expected is plugged in instead of some other one that doesn't
pair with the device. We treat the detachable keyboard as 'not external'
or 'expected' when it matches this VID/PID we have listed in DT so that
we trust it slightly more than a standard USB keyboard that you could
plug in to a USB connector.

