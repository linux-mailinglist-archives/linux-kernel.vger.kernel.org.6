Return-Path: <linux-kernel+bounces-563708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A244EA646F8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEFA16A879
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C593221736;
	Mon, 17 Mar 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="chCUdquy"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5962E21C173
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203272; cv=none; b=gAKoFQMs1xpntFZLUHIc0zGwiUzfUTo2gbbsCSZHDKf3fGg7aHJkNanzvD25HS0Y8PPMd/kR3CWA2yuP4qeMa28lhlQ4+o0DMzRvjRSpCmNk3r52RZe/8hPygbujdWYaO5tICUviDpoZJPDn09cyeIFMjUSM89nbeQRlsCxAz7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203272; c=relaxed/simple;
	bh=8ZRFuRFUDUqJj3cKQoyFy/C2cleZtlOU8PxqFgknmhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVaolhWV6KBk6NVpjyORMhENk5+E7RflHcMZ2V/JBTI42t38WjwYx8AOHmSZsE9J0jsOhEOPZA2Int7ltQqM2tkh15BmYTPR9TRqAAObNrCzwxooGsTpey2IZ8jDz+DhR2ZATWfnqVBuaapjMJpitmWnjjRBgFAR3zevnBlLPFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=chCUdquy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfe808908so73085e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 02:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742203270; x=1742808070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SSVde/RZx/t3S/htNQ6WJIu8kpimnpk8ltox+Q+zPcA=;
        b=chCUdquypbGuLbXSfWC24n4YLNawKvN+Jvqdy5zPMdYLHV7i1miMrBBYyFu7aunbgW
         IFQ985S42G1GdEpHNVIr8FyUptTLB55ko9j3jIduTrUSq8vALA1Fvhe68k1jeggc1yYR
         22KGlA0ejuBLGVISZlIT0qyoBcUCmDQMZRIA2Rn4TlDY7SkFNHhAOF7EsKm9fwJAZv3l
         +KfwWT+bpMSU+i0szOKoxtXuYcy8R8GqeuHk06rPi2EvrXtGQEwIj1E7L7VKxdln8Gcw
         ecMuNsqYOy75n2exMvQ0+37nX9DK813AwxN1wHAjqNPr86+v8grF3LX0b8o6PLUQ0Jpc
         rA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742203270; x=1742808070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSVde/RZx/t3S/htNQ6WJIu8kpimnpk8ltox+Q+zPcA=;
        b=ezaGoGfPsJUwnxLxvP6JRe3R+LCbYi6VCquOMvhf2uFG+9OXZBEF8Xb+46f3OV3PHx
         NeC0wM8XTbryoSWv3nZFHZXK8K+twhKwT0jOaSC7eHQXN5nw44q/CxJRKN4WbPFox6a8
         88NOHlvWDjQAfZLDwojdo83tj8/MWu9hLWNEv9MNnTAcffnVsKV0wvsZJfcORPgpSqjJ
         zI44KeqDzzIdKG4lRmNUnCe+CIe2Ko5fDcvTfyP6jpUAOL+N7w9XqjUPWt8o+/HI2srA
         fXWmofab+bD7/PXGxtfb+4tAd0RT0y/1ko5DgpfmqOppxF5xbuHnvxajrcTnG890rTh7
         bflA==
X-Forwarded-Encrypted: i=1; AJvYcCWBIuzPbXgNPKLU82Eo4mZrTL2OAMtFMvYiy3sbAO/1KauJnnhX/UnWxC3Y8aQEQPYpQ4sCuweb4OKEMD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY7BZtm6t48aSJEtsr5Q2V4OfoxYWp2424QTwVbc50tLq+nj2Z
	H3TLZ+Sk5gKRjkkK8fqLpLhJxfR6p+jno/hkQ0Q+bm8IZQcBRB1L0Xu0PxJ53fNSdfEX0qW2rH/
	v0Q==
X-Gm-Gg: ASbGnctPP+BKfbGVULMRoP2WtXD17Z7Vy8HzmD1G0FlTbJD4+JjBOITiMfxkpOqtFPD
	ZEuXkNqVjc487TOBKfM2pE4JhraqgDhk9WXjoOmLJ2607pOOJ0u/YgBtgOsbGWS2fh+RXZG0OU7
	7kQxmrmEPln+5KdqkRVILrhQ1aE00XPi4B3bWAQEjj39F66iX1SCh2GEj7BALf69fFjU2r/YYt2
	VgNy7E+Sx9Q8dMnV9bw6bL/QIQMACd3u5bL3jpjmOTHrrP+4r9QDpXArEn0MqdWX4/29FvNgx9J
	CIAsl8LBCs6J/UmAim17mGAKefU/M3Bnv+PYz5T5q41w1XNx7YWFCKZXB3+BtxXSAq1CoHqyHoo
	q91eWA6k=
X-Google-Smtp-Source: AGHT+IGQGLnN/NlUXXxSpwF+Gvoqqnmpq/OhToFehZhLbhM0p/w7Vr9QGc7B1fB6dT7cUvEtbEgg1A==
X-Received: by 2002:a05:600c:6b68:b0:439:7fc2:c7ad with SMTP id 5b1f17b1804b1-43d25bbe9b1mr2370115e9.7.1742203269599;
        Mon, 17 Mar 2025 02:21:09 -0700 (PDT)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdc5sm14350682f8f.80.2025.03.17.02.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 02:21:09 -0700 (PDT)
Date: Mon, 17 Mar 2025 09:21:05 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 08/13] objtool: Upgrade "Linked object detected" warning
 to error
Message-ID: <Z9fpgUSuVcM-NCKb@google.com>
References: <cover.1741975349.git.jpoimboe@kernel.org>
 <8380bbf3a0fa86e03fd63f60568ae06a48146bc1.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8380bbf3a0fa86e03fd63f60568ae06a48146bc1.1741975349.git.jpoimboe@kernel.org>

On Fri, Mar 14, 2025 at 12:29:06PM -0700, Josh Poimboeuf wrote:
> Force the user to fix their cmdline if they forget the '--link' option.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Reviewed-by: Brendan Jackman <jackmanb@google.com>

