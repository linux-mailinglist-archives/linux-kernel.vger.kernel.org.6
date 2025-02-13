Return-Path: <linux-kernel+bounces-513594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F79CA34C32
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34EF3A42B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF334204C0B;
	Thu, 13 Feb 2025 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ECU7WBy3"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A8013A3EC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468338; cv=none; b=knT56caw3xgB6hzcOKCE0uJb9hoiFFw+RWwl2y0lwqzXDgXpSV62YljGFRkE0tz82uyFq5HEB7yntLy1Xv+k1ugyN+JJMcw33oHD/TguglxQS9W+8iCfvOe7GVT2bMS7lYeDU0sy60YxqemXXkcsMKb2gJbgZbQsrTEzgBrzCvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468338; c=relaxed/simple;
	bh=b7N+8dSPQ0OnlGTOQ+2/iyi4f6259SWAIHYoRWb24J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0OYEQtyp/D7PfLAxeQKJxRI+XFABM8osgvxTn3Mm83BssN1fkSnSOhlLY/qwo/W+IkH1oxcGSfIzVtC3NIL+EOKkXcg2I8ddVi7RpzeWZ7rERk/QP3yvZdxMLuSziTstGSOz/ELkGq6U3Lcd2KkjH1y14l6n4psovEvBr0avs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ECU7WBy3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f6d2642faso30084245ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739468336; x=1740073136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLC9kfYPwLBjTLU9fLAjv67CM2H+dgqHjhipB5hFLZc=;
        b=ECU7WBy3jbHPomLP0Xv0uYG7Q3Uwur/tm0kyRQqp1L0sCK3uTarWXuth+a+LOA4Umw
         brm3i/Kbk3Vk7W8H4zDLq4Q1KDeVz7TDOn6nyJ0Vyx+UXJHl1q8INHTYUENkFqDu5bgj
         SabyGG1Yp9h18+gTUcWsm7IM+4/kyExktlqaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739468336; x=1740073136;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLC9kfYPwLBjTLU9fLAjv67CM2H+dgqHjhipB5hFLZc=;
        b=Yj4GAg94yq4qqYkeuHgIF0s5hlL6byvq92ptqp/FaD7sNOZzwJ4JweNmbOb7q/Riwg
         Y0A9Lw1fRRi0Q5ATSuq9Jjfo1OnNTSsJQDs08mRDELmfMsSt+YEHAH0bonS4tl+0QvfR
         A4XOWGvd2b2p2FAxt680AXHfPQNhX0IQ0iqMWKjVVaoU52eRQR+EH1tsnTlsYxk3O40S
         8c2YY/rilAOQWkkorD4UB3UCRVu0h+hnOVF76NZzndlWzQc40MLz3W76rz1XA1bt6BtW
         fq/fO9pDJ+gII5EHlYNWshn1yqEfUSbivFULZayStJLIZjaWzgJoIzl4l0bHiv0UX8fH
         e4uA==
X-Forwarded-Encrypted: i=1; AJvYcCVnxGpUINSfGxFM9IA2al7OSoydOmJmq2sq9EgcDf9qjlkW4M3h61jRWWx9E+bCm8WqYqlfDZ06Pmkd6SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMzixOcV+S9XBbNtzyuVouAnl1iZCwS/9TLB4GF0GCcSyVRSWt
	0WLTCDI9UoJ+DBHJy7gbix5Mv4WRjKJ24PQv9qfWVEWk1rpBzyuTr+fsxX/wy9+itXSfswx70ds
	9
X-Gm-Gg: ASbGncurINvPUhBhHfs5Swlemc4xAsXkcbQMlhJ11ENZFk1rpiR08NBMbGBnNCXmLYg
	wYeshCOUZ2RHdSTJGzsjj10PgPmNWGUXGiEch8yoAY5WcmdWiXkxP4MTW0nDhc82k95stitSjvh
	eg9P5E8ajCMdj2Vc/NNuEKIw2oyX5+4/nNJlW8zL+dgWKx1R/bUXyJMc+J/TmAaczvNg0KJAGDk
	t1X8ntutalnDVKeAagbmhAMwyKcoReBoe4ARzMteNTS9+iTrwlF8098J0dDYOCuYeso3uTNVBjF
	vrgrDlKinKa3k+cz0MnChnsfo0/v3KnljeTWT+TqLVyMjpXM/WBrpDg35Q==
X-Google-Smtp-Source: AGHT+IHKx7UoBaIYvNAKG4jbdIsvHPKTWLspdf35/yTjPBwhkv4ORzitL5INUVr5HwUTUERzhGKRNQ==
X-Received: by 2002:a05:6a00:2e1c:b0:732:1ffc:36f5 with SMTP id d2e1a72fcca58-7322c374111mr12059457b3a.5.1739468335955;
        Thu, 13 Feb 2025 09:38:55 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e4casm1588770b3a.103.2025.02.13.09.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 09:38:55 -0800 (PST)
Date: Thu, 13 Feb 2025 09:38:52 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	rdunlap@infradead.org, bagasdotme@gmail.com, ahmed.zaki@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] documentation: networking: Add NAPI config
Message-ID: <Z64uLN63gD0nNvk_@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, rdunlap@infradead.org, bagasdotme@gmail.com,
	ahmed.zaki@intel.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <CALALjgz_jtONSFLAhOTYFcfL2-UwDct9AxhaT4BFGOnnt2UF8A@mail.gmail.com>
 <013921c8-1fd0-410d-9034-278fc56ff8f5@redhat.com>
 <Z633ggyM-F2pfAkG@LQ3V64L9R2>
 <20250213081418.6d3966af@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213081418.6d3966af@kernel.org>

On Thu, Feb 13, 2025 at 08:14:18AM -0800, Jakub Kicinski wrote:
> On Thu, 13 Feb 2025 05:45:38 -0800 Joe Damato wrote:
> > On Thu, Feb 13, 2025 at 12:45:01PM +0100, Paolo Abeni wrote:
> > > On 2/11/25 9:06 PM, Joe Damato wrote:  
> > > > +++ b/Documentation/networking/napi.rst
> > > > @@ -171,12 +171,43 @@ a channel as an IRQ/NAPI which services queues
> > > > of a given type. For example,  
> > > 
> > > It looks like your client mangled the patch; the above lines are
> > > corrupted (there should be no line split)
> > > 
> > > Please respin  
> > 
> > I must be missing something: I don't see the line split when looking
> > at the original email and I just tried applying the patch directly
> > from my email and it applied just fine.
> > 
> > Are you sure its not something with your client?
> > 
> > See the message on lore:
> > 
> > https://lore.kernel.org/netdev/20250211151543.645d1c57@kernel.org/T/
> 
> It's also broken on lore.
> 
> The first diff block starting with the @@ line overflows and gets
> broken into the next line. All lines within a diff block must start
> with a space, + or -. The "of a given type. For example," line breaks
> that.

I see; I think it's this oauth2 helper I've been trying to use with
my google cloud account. Arg.

I'll RESEND this and my XSK attribute thing, too, which for some
reason isn't on lore but is on other sites (like spinics).

