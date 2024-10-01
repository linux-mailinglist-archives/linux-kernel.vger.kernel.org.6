Return-Path: <linux-kernel+bounces-346340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2194B98C352
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5E81C2437E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120581CB51E;
	Tue,  1 Oct 2024 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tLiDJ2lg"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099DA1C9EA6
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799725; cv=none; b=KuegXqviK1uVh30uuF5O2Ge28Q89zO00qJ5FwdMKIqsSRZNY2AMeT7zHBMBNbeCcwsf2Awsc2KEQ9zqSA0xaFzpA5204+fiyuKHctEqke1U2a8HXmSN69yQ9qDWcG84MduvDxO9SFpdByoUBgvqZZP+bzaGgBijMfXZxU5q7UQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799725; c=relaxed/simple;
	bh=gcCzIJZeIGcl46n0fjBqKeojKcYmVfWPrJBsCMkQDSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ws4gQ+04tfejNlLLQ3C8A+1UUZw2pvA6jZKVJuPsPEkCD5te5W00lRyxZ06nVM5Rq48VsE7nvK+/n5/nwFrZ/xwuW0Clh5PUmENEStICcaD8IbpduZXoYHqzS31ue2NGaXwdp4ey2A8GOl2mSUyxi/yjQwe2iv4UZsySIVTV21s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tLiDJ2lg; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71dba8b05cbso1007220b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 09:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727799723; x=1728404523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6534ybpju9tDRdwijk3ltMgmd/6M6CgfXK45W6fp1TE=;
        b=tLiDJ2lgKq9AtFJSubmzDpsuMGkkF7a4dhyw6YrlxWu2YGOhApFI6qtwfw4O8w2JPR
         R+UslGUj2aeGf83SlWHlTD/ywKK++ZRKhWBt6kaK1SwhqZDAjiOxQNnBbP65zHGuUftu
         vtNrW9/aDzknipI8dbLpZot+YVdi3C9XVQF/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727799723; x=1728404523;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6534ybpju9tDRdwijk3ltMgmd/6M6CgfXK45W6fp1TE=;
        b=EFUvzOzg3PdK9IPqIHzs9nyDTw+HUyTAEqwA78tEPd8OyzBAhbj+gi5fFVFZuu6T3T
         Z67i9o4eoniyhukLdSKBaT/K8O8y2RnecSAwAOwb8OZwNvaJqIqJUH88UDrOepLSMvhB
         MG2RRhL1vyRZF26KvghqSpOQf8oQpbDcSViyBSyZGB2ibJ7jv6EuVjNI5V5TKg/8SZMV
         5h/N1kyoHdf0aKqMY1DEt5AICeoY3Qz+m68Fz+hMVQdnYf/PbYxAEZEbwz+2XGr/+r32
         0+6PfOM4kP3odF5TNQ9nopzPXuf7SaCHgSZXdia/28MNuPMrwRvWAC8GVkZBERjtordM
         W7Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWE07moF9CKJLrjGDUcVuVviu1NBaZN1z0qnmIk0/pNsiUgxh8sTeG0tSFw0AjPIdxRaclLSiCNbijqpaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvtJyvmSJM36qx15wyIEcOFSuwEdyWlfChbBrnXlryO9eYdU1X
	hTKhP/lSkDsFZXsrVVVH5ax2XBxgcluuNuPBU7quIKiqlWA9gfwQAVAs+FAtn/A=
X-Google-Smtp-Source: AGHT+IGbIXhLey/YycH7vBeplAcObPrFchkQi7j5m2H+tlso+i2zeMqCaMByDHr8IXyYtQI2JYHGWg==
X-Received: by 2002:a05:6a00:198b:b0:717:950e:b589 with SMTP id d2e1a72fcca58-71dc5d429f1mr348713b3a.19.1727799723153;
        Tue, 01 Oct 2024 09:22:03 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26536c0fsm8249488b3a.199.2024.10.01.09.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:22:02 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:21:59 -0700
From: Joe Damato <jdamato@fastly.com>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"Bernstein, Amit" <amitbern@amazon.com>
Subject: Re: [net-next 2/2] ena: Link queues to NAPIs
Message-ID: <Zvwhp94ZIf665N6A@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	"Arinzon, David" <darinzon@amazon.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"Bernstein, Amit" <amitbern@amazon.com>
References: <20240930195617.37369-1-jdamato@fastly.com>
 <20240930195617.37369-3-jdamato@fastly.com>
 <eb828dd9f65847a49eb64763740c84ff@amazon.com>
 <ZvwHC6VLihXevnPo@LQ3V64L9R2>
 <26bda21325814a8cb11f997b80bf5262@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26bda21325814a8cb11f997b80bf5262@amazon.com>

On Tue, Oct 01, 2024 at 03:50:24PM +0000, Arinzon, David wrote:

[...]

> > >
> > > Thank you for uploading this patch.
> > 
> > Can you please let me know (explicitly) if you want me to send a second
> > revision (when net-next allows for it) to remove the 'struct napi_struct' and
> > add a comment as described above?
> 
> Yes, I would appreciate that.
> I guess the `struct napi_struct` is OK, this way both functions will look the same.
> Regarding the comment, yes please, something like /* This API is supported for non-XDP queues only */ in both places.
> I also added a small request to preserve reverse christmas tree order on patch 1/2 in the series.

Thanks for mentioning the nit about reverse christmas tree order; I
missed that.

I will:
  - Fix the ordering of the variables in 1/2
  - Add 2 comments in 2/2

I'll have to wait the ~48hr timeout before I can post the v2, but
I'll be sure to CC you on the next revision.

> Thank you again for the patches in the driver.

No worries, thanks for the review.

BTW: Since neither of the changes you've asked me to make are
functional changes, would you mind testing the driver changes on
your side just to make sure? I tested them myself on an ec2 instance
with an ENA driver, but I am not an expert on ENA :)

- Joe

