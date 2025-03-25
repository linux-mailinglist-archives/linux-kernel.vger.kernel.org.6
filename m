Return-Path: <linux-kernel+bounces-575762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BF6A706F2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E973AE191
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5543A25D55A;
	Tue, 25 Mar 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE0avIrz"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0C825D530
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920219; cv=none; b=g9gIf2SKEHZ7gYET6WtKkYvUJ31xM8EiyFy6aLds72HICT1J+CUcS75ZcTla4qJPp1paR87RRNA0UvcPsD/N6tqKGZzSRtvsUWxg4sCXab/YUjuO52np1bckMk9YHwNeTc6K0oDd6zxZiLabf4orzyQn+5SC1LbY1UuCF1npXIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920219; c=relaxed/simple;
	bh=Kb7vSHn4zmJXmVmPF+ez3noeAspoob2LmYsHA4oLIAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hV1sOHLZ7KKv91hlBlcggMmWTVE12Dz2YTun31amF6K6T6zbabiPojFoYhVqwJr4jF5oRM08RwZqZfWid2z8PHTl08l2MG7xjUPjGQbydFRpHwBz8PegPkBLzhUnSHKQBO7zYFlurK2NpX2vBLEtY7momm6trMEApVdXE0fB2Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dE0avIrz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22401f4d35aso123802235ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742920215; x=1743525015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7XOEBoIoTxapXkqN32rureiAN9LUz3SUdTVTRufLCvo=;
        b=dE0avIrz9wnfhsL7T1iJd29r0snNgirhDOMwYEGJbndt3rucplzFXlqGb2Gi9lH1os
         f7j5Tw6fWWjXRKh54cKDIICH0MQ1DfIx/Dxp9N1QZtuCV7Oij9ZYPBSb8W+StWxEp62w
         OhJBLIMaRxCzAGaWwGHXNwfozqlrozOkryLLb/6SSS1VXgAlY5VZUwalLz524O9j9DoX
         dw9dTVCcr5jfcomwXXPoXQ3Xp/p6FIBhVA9PfNfsTFQqYI5kxsPkC616PbWAhhZeZ10D
         1v+5nDO1MLya9oRLrNMns7paKEZrFHowYgFSVReNeDDi2YRX9pPk9Ey4aZepF5qMuLjT
         eIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742920215; x=1743525015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XOEBoIoTxapXkqN32rureiAN9LUz3SUdTVTRufLCvo=;
        b=Fu6Gt4MN2fwX8HqJDIZe9nWCmHJy5s0ye/H/7Zco9/a7SYh/V+c1MutUtaMmR+FHnW
         A7/dQWyHu4betDPvkWi5Hsuv41+TXRmuzNqVq/fcThSk9ZalXcK06org07mizcMZMU7Q
         soXLbWMpMfPxVq0ZGm0ETmYJPcrkvz3snXbZFeGACRCJZADnK0Qr1BgLx+ghRgmx582r
         Zr31wHsLYUN9jAIrA1ee8T1PHOpS7DhY2VM0dNbNX1I0A9SjWJTMGHN3Ip4DphzlMP6W
         ah2glDm1JwqV0XaEWOfE0Bo+jfGke1Evlf4uiOVvD2tmftguWeUXIEsV0RhjJk8Xy9wQ
         SprQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhmCAuU6tmP+HelPzrGwQ5HSolsrmnkSeKm2LGMOEilMQPUzozQqKakWp4O+X/c24Ehvein5qrsOOIwpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMfA0ByOvLUBiizXHNaFl9MJVurKeigtbrjS4T0mO6ASeWwHxq
	bXZHgRw/vOoh6yq81vi1Y63YfVYhAB2OGC7Jb+WMB3DRlWR980Rd7qf9M1ZE
X-Gm-Gg: ASbGncuU3h1rkh9xAPhY5UvRsmRrOhZ8vhSqzKI/tOeyULXfPxcJG0fQzmr91VXBGxR
	G+2g2xS/2J1u6NYGU+uaoGoOmX9Zfpv4o8WA8SqOi/1K7HCxGlMhAL3kGZ3xu92JxJjQjQHRcVa
	aBKuPE2wd04hhWDBSZJjqQTK+KBGvKjUFlpC4NmymM2bmsaRa6zVQ0UZvJi71nPLPFn4fdPAkas
	KhdYPYFBrCtRw/hPaAKsfonJ4L9kQCC5/1rMNEjDlDOqR6zOUOKNl14LLma2TaA6z6ujbZLePN0
	hRIg0kVUiZtnV7Qhjtfu1cUUEH+8yxdti0ZnaLYvf5o+
X-Google-Smtp-Source: AGHT+IGcGh1uUnRJ1nh7gGywlabmECcecS4FX72r/Ur9GzJ48tu+/YOISn4PE+ECHi2P7HDwl8PEvg==
X-Received: by 2002:a17:902:ec87:b0:216:393b:23d4 with SMTP id d9443c01a7336-22780c68a0fmr268278305ad.11.1742920215330;
        Tue, 25 Mar 2025 09:30:15 -0700 (PDT)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b2bf0sm92890235ad.145.2025.03.25.09.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 09:30:14 -0700 (PDT)
Date: Tue, 25 Mar 2025 12:30:11 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v7 0/5] bits: Fixed-type GENMASK_U*() and BIT_U*()
Message-ID: <Z-LaE8u8ZYsLxnrN@thinkpad>
References: <20250322-fixed-type-genmasks-v7-0-da380ff1c5b9@wanadoo.fr>
 <Z-FsJPA1aq7KyTlm@thinkpad>
 <7e114fdb-0340-4a3c-956f-b26c9373041d@wanadoo.fr>
 <Z-LKapMBpMfJwcL7@thinkpad>
 <58d6a3ba-4db9-4b17-a2ba-96d7f8b52e85@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58d6a3ba-4db9-4b17-a2ba-96d7f8b52e85@wanadoo.fr>

On Wed, Mar 26, 2025 at 01:13:28AM +0900, Vincent Mailhol wrote:
> On 26/03/2025 at 00:23, Yury Norov wrote:
> > On Tue, Mar 25, 2025 at 01:23:22AM +0900, Vincent Mailhol wrote:
> 
> (...)
> 
> > This series doesn't apply on 6.15-rc1 because test_bits.c has moved to
> > lib/tests. Can you please rebase your v8 and submit? I see no other
> > issues to merge it in bitmap-for-next.
> 
> git was smart enough to rebase everything automatically!
> 
> Here is the v8 (which includes the other few nitpicks from you and Andy):
> 
> https://lore.kernel.org/all/20250326-fixed-type-genmasks-v8-0-24afed16ca00@wanadoo.fr/
> 
> Do you also want me to rebase the other series which consolidates the
> GENMASK(), GENMASK_ULL() and GENMASK_U128() now? Or should I wait a while?

Let's wait for feedback, especially from ARM folks.

