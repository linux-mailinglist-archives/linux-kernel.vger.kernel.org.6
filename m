Return-Path: <linux-kernel+bounces-560483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692D3A6053D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87154421146
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925E21F8916;
	Thu, 13 Mar 2025 23:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ExDf4pjQ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F44E1F3FE3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908226; cv=none; b=lyRDSzUItxy/jFevV7tfVPreyQhhcwDtxfi60k678Afaa4cqfob/6OcTWtQmhUmW4KE42DKfRm0IfLAGvYMEHGNgkISj5OX9pv5PvWfcKGWFVSBU+t2V4eK5hEc95HF2Bf1jCCsIUJh8cj7QjRrUqPy/YeTftW5IbBZgERLtvLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908226; c=relaxed/simple;
	bh=03hqJnuK1CVGKDG0J1rE6YrOQUCHMsfOL+m7YMiPdhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcYYEHaDSHgT3h+N63gAYB0ucinTTllthIh8bBHu/PHHvaDgJCeEwL460GTXR9xKea3wNxhAp6aJMan/uC+Cjv2FWz6lSyIoVUqhwm9pcW0gzof7SHvxs8V7EF6In6hmpOSV1saIxkZGxRsb4uwWWkXrbnaC8Q7Sa0F/2ydOup0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ExDf4pjQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso3063939a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741908223; x=1742513023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCMudYCsiUfPpJxSCb7AZiMA+eXp5wJ3W7GXcaA01zk=;
        b=ExDf4pjQfp1STxOGaFOIKKu4iAilipjbozgjiF/RFIso1rPGbNSGanyHv2vImj4CWm
         i2ujErX2mh+OUafSLw8ucqF8hKLPZ3C+YsqqsbvuM37EoxyOCe2R8b4RDARUHY2j1MAo
         KqjZnFjhIAVyYMgpkSMpReNE4IICwU7rUYl6+8ONH/bKexu9FP5PEqdqfk9+QjZF41Uz
         NrYr2XnB7kNw5jEpyj58WH15GIhV+qxIK8GnEPHJSUCq8LBrHdzM6wJV2c6VZ6HJfw02
         kw0sLJOyCEX8KwYlaBQNfe5foYjzFRHzan8aXTnqWpAGqJ9IZE0CTZNQGJTVb3AZGKSU
         Vcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741908223; x=1742513023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCMudYCsiUfPpJxSCb7AZiMA+eXp5wJ3W7GXcaA01zk=;
        b=gZzWo9XCJKJfVYTnlPWtJTtiqEMxOULjWx0NH2jR3uu1x6F8pEx8e8E2etPD0ZfSsD
         10VjZ/wR8BIftoBUb76X74UfKK7FLz4/1BQLxzzHW3ZJbQZadq/IFpnDr40/t0QGtBIC
         SVZEE7Ml0aUK4Bp8yjuO7DUSPNOwoSG7FNa7JMkVWPPnUKY5zcaljgmwBSZWfq4hmfs5
         G3Cqc0dztIcG/o+lACTI8KQaJUsBeXug9u5Tmra5p3CNXM/ejkSRZwtO3qBEMDCJ8pis
         J+065VhSznMpYEK3yazUDrOS4V6tUnTRNthadj3PxT2m2pNpSYkPZ2BXSQlvJitSBI6B
         H7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWj0+djDJraR6IKv525M3fnLsLWc7MMSHFYl85teKMetKSrm0Nguxu3O5CsobMvnPt8/rZvanW4GAtJlkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyybB4GLJ7sBO93Bt/4/tOC+pzXkR1PcdxJ6lvmEIZHjxUsO5wF
	/xBPykvyv6bVd/B+HnVIfaozFdnpG/9wJzk707+4lmCIoh897GJMj0oqB4H3cSPLYqXPEbyZTpq
	zJM51sQ78cCMSFP20b/QKZcx032BU8W+QAoAT
X-Gm-Gg: ASbGncu5C25MpnUO9HZneXi498ExiutstuPuvYYiyTGTRg43acDsuGIGihXcpeUpVyy
	ADn8t9CB3t+mVuIrKW8X40CfnPNHPNTkz8MFddK17QrTkv2e74CFckbQ7KwvbRL9Dih03ZsJjcg
	27KycbwCOLYKRrJA/2Si0RWMITdNTB3ny8lPsCVhSuV8FIA3VrzM/FEPA=
X-Google-Smtp-Source: AGHT+IHjRZmiFK4Q9ZkNGdZSuSwWBLKWpzjANTknswcUF/yqPrUOK+YMTqHc4G39LZMn33UVLCx9GiofUg2Ysz20FDE=
X-Received: by 2002:a17:907:9694:b0:ac2:d2f3:6c30 with SMTP id
 a640c23a62f3a-ac3303db128mr36303566b.49.1741908222584; Thu, 13 Mar 2025
 16:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312195951.1579682-1-jthies@google.com> <20250312195951.1579682-2-jthies@google.com>
 <13c6d57b-0235-4c8d-95ef-111f87d6c25d@linaro.org>
In-Reply-To: <13c6d57b-0235-4c8d-95ef-111f87d6c25d@linaro.org>
From: Jameson Thies <jthies@google.com>
Date: Thu, 13 Mar 2025 16:23:30 -0700
X-Gm-Features: AQ5f1Jp4TvsDR3UGIWQbuMD6uRPeohSBsXrCOM-uSTZZYdf4-rx0RWVAFEBnFIQ
Message-ID: <CAMFSAReJpppA5eb2mxf8ZCwrR1HcBeGWaNXBoFmKq5swKboMJw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: Add cros-ec-ucsi to cros-ec-typec
 device tree documentation
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: tzungbi@kernel.org, ukaszb@chromium.org, bleung@chromium.org, 
	heikki.krogerus@linux.intel.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, groeck@chromium.org, swboyd@chromium.org, 
	akuchynski@chromium.org, devicetree@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof, thank you for taking a look at this series. Clearly it
needs some more work. I=E2=80=99ll follow up with a v2 addressing your
comments.

> > -  cros-ec node like google,cros-ec-spi.
> > +  cros-ec node like google,cros-ec-spi. On TCPC systems, ChromeOS shou=
ld
> > +  use cros-ec-typec. On PDC systems, ChromeOS should use cros-ec-ucsi.
>
> What does it mean? How is it related to description?

TCPCs and PDCs are different components which can be used for power
delivery messaging on USB-C ports. On ChromeOS devices, they are
mutually exclusive. This line is just saying which driver should be
chosen based on the USB-C port hardware. But, I see that type of
information isn=E2=80=99t really relevant for the device tree documentation=
.

Thanks,
Jameson

