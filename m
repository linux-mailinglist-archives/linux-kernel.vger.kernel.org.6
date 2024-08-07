Return-Path: <linux-kernel+bounces-277722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA78394A542
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95273283F9E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9761DD39C;
	Wed,  7 Aug 2024 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="DKDLLKiB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XCdt3K5w"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C31F1D363F;
	Wed,  7 Aug 2024 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025923; cv=none; b=GLN95MNnXo9YeSm6t88zzbE8lLzEUFbxKDbb+ZPqmUUHMd7Ow3USvwtNHVMWDST1C0K0a8whxaPFGgGY7Z71pjmez9pVrAqQz+KzDil7EJAeCqadjV8MlFowyWYH+K7G2+n9MaLtVtrh4tkBr/o66aODR+PZ9czUtcUT2zs0m9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025923; c=relaxed/simple;
	bh=X0HeSAtzmsjESSKMcmxnTmFKNCAPomDKOxgSsDBnavU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGSTY6WF50hPhAZTmaGOioOLz7xNL+aG6SvMolHHWy/9vMEeSViZEgOjEfBk7FgAjB5V7xS+zceQ7nWRZi8KrH2VW8EAlBTz/P9z6HX6UtMirKYWEq3NxvxyczL5Ra0OiSkcxFWfZWK+/KyZp30Nte9p0zenilnlHNPlgCwYQkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=DKDLLKiB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XCdt3K5w; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6B9C41151AE5;
	Wed,  7 Aug 2024 06:18:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 07 Aug 2024 06:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723025920; x=1723112320; bh=QbAgmVgVp0
	hFDTgUq0qc7ahe7ZcxYiE4fZDH0BN/XlQ=; b=DKDLLKiBWa6yd3lhxf9b1sNLlR
	1kSgtOex2pafyHTWkOAG/rser/YG7BYW+O4R6PaKrOR1BK81CRclaGEuflHOwzy2
	IFzVkro1six68WtUvLGDriwUODHGhbLQ5b3rwYySSmO41iaKXC268BGuirIsMR0/
	zVZghFJ1qCUu3KpaOpcoLTFSea2DUiEwZH+jS0i8BB6GVq9JzUWGX9TGnSZzVwqz
	S/FJHycZvEBfaowNkyEzh6YQsreLTXppNu7JdCgw6R2qpGj26eF54KOrQpMzI/J6
	dwzeaj1nxaNjVJl5Yui6JYytdRmsWJjOu60I/o3uHcV7fquFg8Tdv1OJB0nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723025920; x=1723112320; bh=QbAgmVgVp0hFDTgUq0qc7ahe7Zcx
	YiE4fZDH0BN/XlQ=; b=XCdt3K5wHu+skkEXVu0Xq2zUCV6njAWYJdVisdUIM9ZJ
	Whu52d9iRPAoH+DxuAW7TphKVF4fmVGYJ2h/bJcFYPIcsx62imrRI/U94JZ0LuDc
	IGJyQabQXEAHD0sRqft/FtGfJjaoRrYQIDJyliMn8UXsyardm2L3gpbVzfwcQA8r
	7xbJpAGbIDmltH17Z+nozGELQSpD560Tzb8a12G2jYHxRlQdHZyeLN89HotPzmzK
	2xlWfgqohWtpyRFGsWrsJrZw21dPGQA7kwT4jLHRvoNiCU+I6pW5NuX1vBS5DccJ
	HZi1gpKzcnD38hthYQMrkkmV/vfHvG47gMHspbeCvA==
X-ME-Sender: <xms:AEqzZm_PKx9xknBeIgCtHCE5g1nH_6UlNTOB_VSJA4_bIdKbh5itRw>
    <xme:AEqzZmsoT2aqFoP_0aFud4FJcMYhIaHEl0nQGLJz_1IxQ_eVz06a1F5QEgWBhSXY-
    RI4BVa7jqnF2g>
X-ME-Received: <xmr:AEqzZsCvCLKB6muEr3G4yW5nIBJUa1iL3X-xcAw3GnymRa_q8tUvUcr18bzK98h0Fd1k-q0uXGLLbBOHVPGSokn_R6VwC-MVKAGqDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:AEqzZufAfGW3q0ZtIAiz4d1-QYo7wP91o9KMDLMq8DTL8kyUyikHWw>
    <xmx:AEqzZrNwpa5TfpgZy8NUN85LqyvNwft0z792QWFIYxPfREUzG_tgUw>
    <xmx:AEqzZolqnJ9HPWGN1SV9rBKgg0IzFbo23xRI7qOm7bUrGpktiDcOWA>
    <xmx:AEqzZtsDOvRjqAF6eLMuIbaRhuPhYIJ5T5Edi6b6YrLzVwhlmaZ8Jg>
    <xmx:AEqzZsGVZWT7b0xrJ9117RrJMy7lgX9MKFbvF2vCHKpry-1AIq8s1r-x>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 06:18:39 -0400 (EDT)
Date: Wed, 7 Aug 2024 12:18:38 +0200
From: Greg KH <greg@kroah.com>
To: Chris Wulff <crwulff@gmail.com>
Cc: Chris Wulff <Chris.Wulff@biamp.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Sands <David.Sands@biamp.com>
Subject: Re: [PATCH v2 1/1] USB: gadget: f_hid: Add GET_REPORT via userspace
 IOCTL
Message-ID: <2024080733-guileless-t-shirt-c4ff@gregkh>
References: <CO1PR17MB541952864266039BAA7BBBD3E10F2@CO1PR17MB5419.namprd17.prod.outlook.com>
 <2024073114-singular-stream-1dd9@gregkh>
 <CAB0kiB+tzV2JPc2X_WKr5yMJ5sy7QO2o0mcqUdD8CMd68EGmhw@mail.gmail.com>
 <CAB0kiBKpzQjcH02ckCFH0Uxv4QGVLEwVUE_ZtE8L9zd7H0Ow-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0kiBKpzQjcH02ckCFH0Uxv4QGVLEwVUE_ZtE8L9zd7H0Ow-w@mail.gmail.com>

On Sun, Aug 04, 2024 at 10:19:03AM -0400, Chris Wulff wrote:
> Greg,
> 
>   It looks like this still applies clean with no changes to the diff
>   on the latest usb-next. Do you still want me to re-post it?

Yes please.

