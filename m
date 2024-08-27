Return-Path: <linux-kernel+bounces-302794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6D6960366
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC56283BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8B9158D79;
	Tue, 27 Aug 2024 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NKMs3uYf"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB89156653
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744429; cv=none; b=cdwXgCAQfXXcCRWJP9HE27Knb8GQ34cs0q+rY6m7KqANoDl2t0fO4vnCBIvnhptBaJ54zn58DVy+LxvOSEq6AQDera96Mt1mQQQRDgx8SSNB99dYx4GEqQZbKmjQC2k7Ac+5ilSFlncy0Y/7qUqruGL2Id9PtnZ0vTtbxv3zfRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744429; c=relaxed/simple;
	bh=pljMeg/tZIYLgASZ7cHtr7dCWNo79/sFWaht/42VsCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNv9D4oYUcr8gplmioXt+WN5y55KuVnRBil0mRcmxYIJA3higOr2P+Zk2UBZvDUTe5U6QiMGAVZ6SACVZJqcemYvDsrO29JUash6xxJ67BejEuLLpSKFyUJyqZU1FV0/EmOyuTogRhAvkg0greW7lRb4ovj3vp8b9Cj/uUxdLdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NKMs3uYf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a83597ce5beso796772066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 00:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724744424; x=1725349224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pljMeg/tZIYLgASZ7cHtr7dCWNo79/sFWaht/42VsCs=;
        b=NKMs3uYfwgiFBt2pns9ZUjCrLAoZyxnrqxtWg+0GSFDgytouBAHuIM9zqnhtVDzRIl
         UHsRtVlq5CMaZ5/urVMuynu6Ee26LdTDNPZSgtFSKzpcQP8HbMph6BPle7Ja+pjNyMk1
         G+wGdfXHr5g8NeYIU0DaS4bWSx91vt/bk6zQ5JQBsH/7+m3OJmUnQ1KKE5Sk5uV3sybV
         fmrMZKZMu+A95p9skR4t5WEYC5y68DnRvhcUpClQ/lt/4o9Q3Sw5PG+g/Qs8IIOkUyCK
         ZRBrStdL5TLFkW6zxSvFtZm/XE1lKQSB60oM5xUzQ7XavoioOktvWZiNawO9iJC8pEYn
         r4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724744424; x=1725349224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pljMeg/tZIYLgASZ7cHtr7dCWNo79/sFWaht/42VsCs=;
        b=Z9F3m3k7HwmVzq9UpfhhCs8ycK7CfcY85MdgnsDftyz224FBke8rVJhkZHEiA2jiFN
         AUUY6s5RhfpX7rVwl4024+yr2Z5v5VdnEjrASp3x3dDZ/u6UWNmr0XHyaQ3eUF5Se+e5
         ABm5Ad4McbT1+le/B21X+TjF51SOjt9UAd/ov0UsCsL+35tki2Gl7pd3aOiVLnCiVQZk
         GxEKybmhy4kbCWDPGfB4diX95YRjk2QoF6emIwSlrqfJC5Wx96kwr+Z4WM4OIfGtcA5E
         9uTxEwMJYbQYsuBwUQTbNMXFPS6EjCCoIfvbTsnbPtwzmwJuUk6LgzRuXJLsSgUxpbCA
         +aDw==
X-Forwarded-Encrypted: i=1; AJvYcCUFmU5UOsnN0iJKjeV8MgnJssGyBk5BePhMODfMKelrHBOOcTg9MxnXY5jGbVRYbRG/rMLNpaHfetjccCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQvVuR9RPyI1LcL+zu7m/wGQtmJTDo9Iys+LqhBmiSTE1s9Uob
	wq/NJCKtiWZMU2TtQDT/9Jy0SnRVPeieJFVykqbUzK28eyOk4GiRLORe7kRqPgs=
X-Google-Smtp-Source: AGHT+IFV3VSINboGZ5Er0ne8BDV200ac18VnmBZ7QML+x8/y19gkiMEZo0P87rh59ZwRG9YzJqUzDQ==
X-Received: by 2002:a17:907:2d8e:b0:a7a:c7f3:580d with SMTP id a640c23a62f3a-a86e29feb8bmr192161466b.25.1724744424121;
        Tue, 27 Aug 2024 00:40:24 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5485671sm74803666b.30.2024.08.27.00.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 00:40:23 -0700 (PDT)
Date: Tue, 27 Aug 2024 09:40:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] ice: Fix NULL pointer access, if PF doesn't
 support SRIOV_LAG
Message-ID: <Zs2C5nlDKlgxd32a@nanopsycho.orion>
References: <20240827071602.66954-1-tbogendoerfer@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827071602.66954-1-tbogendoerfer@suse.de>

Tue, Aug 27, 2024 at 09:16:02AM CEST, tbogendoerfer@suse.de wrote:
>For PFs, which don't support SRIOV_LAG, there is no pf->lag struct
>allocated. So before accessing pf->lag a NULL pointer check is needed.
>
>Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
>Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

