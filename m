Return-Path: <linux-kernel+bounces-195158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114228D485A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B28B2535E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CD31448E1;
	Thu, 30 May 2024 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxRdq1OL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C31E6F313
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060928; cv=none; b=A+jlEXvRumxo0pXaLPutANd1l49xP5iIsuOKHcwGYKNE7+2zXj8xN1wJnL+5cr1JQSLOO3fO/77+Q8evpMuL+FHO8DYQNvTrtrHsbhq/WHvq2oJGnu/3gHC33Z28qT9mHtaM0HKdOoCaGynvir3ZELOH3bF+6/y4rMfIOd/K1KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060928; c=relaxed/simple;
	bh=OqKSG6djCO9zLFFUipf9Ba5cny75hPFnkNt75pgy9mI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BfSVedVlZd6t9mPjWbsHkjHzZVWlov9vhBbD1IOaU+0LhDI9SkgGyu/I7p/hG0AS3tJ849GJ4u14Y2QMLyWXY7FCnSVTRKBmk1dNfUTERkvtFV6yZIIi3a8tMktq/Rt8WwjX8mzYYO7veVAOoTSHTFnKkJgCkRBwLu0mIKpZiCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IxRdq1OL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717060925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q0kOrP8HSB5AcAtcogW7ASpHOd1PHAPOAoyjCy8xOvM=;
	b=IxRdq1OLjSrIo5MvrvgaflF8FaoxaItKA63Wxv3XmIP/5WH+48SwA8v1dXu6lV7b8se0rJ
	XbUu8VnFaUxEgZwQ7bJmRhgCF/eF1GQvbRneTU9RPGg3lcp3Tnop37RO3BvpbrILbpGRpC
	mxu63Bg7ABJWXBXMBezJRhcV2kgfUfw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-OfPbx5m2OwysuAq739o4zw-1; Thu, 30 May 2024 05:22:03 -0400
X-MC-Unique: OfPbx5m2OwysuAq739o4zw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ea62132a6eso1035401fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 02:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717060922; x=1717665722;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0kOrP8HSB5AcAtcogW7ASpHOd1PHAPOAoyjCy8xOvM=;
        b=nrj62yBTUJCp5dHqeFQU5KeFiU1CJqM4CfVZ75xYoNir42QGKztPDGnFPAJwF8UUMa
         UaeO1O7aslcC6KA2rSXcRomGHAI7GC5n5GCrjrH/Y3iFosW44lSSmCIPxMrL7/GwnM3b
         5/OSnNHdKkHGZavmhg2sem18GyZvzDVL/G6ByjQzwQ4S7DKg4qLBkNW5WOziO3YnKkqz
         AczUA4yCL5L+pd+vfewJ+odGKjMvWtvnOZt4Vi1n3HaYzwzu0dFc9NSCBg/YOd+CRxii
         M3ZRDrYQ7EZLzwaCR37iW/t79UP5SLxC1JtW491Uu8ryKXi+fd45cWGC/Tdi+W7nQ4rz
         JODA==
X-Forwarded-Encrypted: i=1; AJvYcCUDVNl0GQnLk2R9K1h/eKVPXrFazFqRhgVDolM8BbQN0JGdQ+1JktLx9B6vGpiutvt2VNSDGJC148AY2YvCHHFSolyZiZkOZqoq3IDE
X-Gm-Message-State: AOJu0YziAMtWL8RwKJBtlK5UJnuVWbB6QXfgqbju9V7y44tc8z8WkbNh
	2zv+SoKM+tnV1wBOBi01WHoym8b/F6O4uo/H1I3nYRdXvGQIi3MRUlW9gjlxi8lAngndXObk1Ta
	3NTVkmnKmzJEJZ7zWQxYQB2kd+3bGuEouVSYY2Yy1RXFs2Wm+vVxUjiUz+YJA4g==
X-Received: by 2002:a2e:b054:0:b0:2e9:5986:c86f with SMTP id 38308e7fff4ca-2ea848c2f10mr9166531fa.3.1717060921747;
        Thu, 30 May 2024 02:22:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4Vp8ne0d/dZfu2/f59RJ/IWfQ0vLLx1VyqtkRZ3EqK9NOJD36dlaxwVsHrT1Rdf/SZ8xIXQ==
X-Received: by 2002:a2e:b054:0:b0:2e9:5986:c86f with SMTP id 38308e7fff4ca-2ea848c2f10mr9166381fa.3.1717060921257;
        Thu, 30 May 2024 02:22:01 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42126feda3esm19614265e9.0.2024.05.30.02.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 02:22:00 -0700 (PDT)
Message-ID: <b52073452a085524b436762aeb3aff8feb8005d1.camel@redhat.com>
Subject: Re: [PATCH net] net: phy: Micrel KSZ8061: fix errata solution not
 taking effect problem
From: Paolo Abeni <pabeni@redhat.com>
To: Tristram.Ha@microchip.com, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 30 May 2024 11:21:59 +0200
In-Reply-To: <1716932254-3703-1-git-send-email-Tristram.Ha@microchip.com>
References: <1716932254-3703-1-git-send-email-Tristram.Ha@microchip.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 14:37 -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
>=20
> KSZ8061 needs to write to a MMD register at driver initialization to fix
> an errata.  This worked in 4.14 kernel but not in newer kernels.  The
> issue is the main phylib code no longer resets PHY at the very beginning.
> Calling phy resuming code later will reset the chip if it is already
> powered down at the beginning.  This wipes out the MMD register write.
> Solution is to implement a phy resume function for KSZ8061 to take care
> of this problem.
>=20
> Fixes: 232ba3a51cc2 ("net: phy: Micrel KSZ8061: link failure after cable =
connect")

As the blamed commit belongs to 5.0 and the changelog hints anything
after 4.14 is broken, it looks like there is an inconsistency. Please
fix the changelog or the tag.

Thanks,

Paolo


