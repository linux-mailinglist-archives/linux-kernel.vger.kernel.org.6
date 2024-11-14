Return-Path: <linux-kernel+bounces-408753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A0C9C832C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05312B24452
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B4E1EBFF0;
	Thu, 14 Nov 2024 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="l/m2ar5X"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DB02905
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731565796; cv=none; b=PuV7r5ZLCkW95gHO59e4p/98plsDLvrrKmtLIHKPCPafar00N0JqHiYSc+gqleS9a1qA7d9xlBslhoIXTPQdgOvpZi9ZspAfwismj64mdYWA6nPBu6qFsGqI4YlnXotKEu5osigvVXphtMjO2l+6voV9JtYEQtkikEls9C8knSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731565796; c=relaxed/simple;
	bh=3+namQukeZLx2CV7DlgaX+q4V2zRXwnmPu+JiK8qS+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChrkrJm/6gYfwuzO2b4YQ8oyj1WWj0yyJgOWDuk7y3YNndjNrTXjWZFsMLqscb3LGqOM5jFc9sl6m1YTPbNhpdW1pnnKVyDHYHeUM4pRpflfcbWt6SBZCKh3Bw2BhhutvSQIsqZHDEkgyet5wWe5/bx4TUznjybYrIBcmOk1HJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=l/m2ar5X; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e91403950dso222199a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 22:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731565794; x=1732170594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1U1d47krDEIIdDqbZ0ejinn2L3sss3M6fc+t7cgpMg=;
        b=l/m2ar5XtOzpZfn8q/ouwrOY51Lv2ELudVY5Lm0xOC+tOEJ9DSaSd04vJdpwUWY0eD
         TmzC6K4w/U/vFbsa8i5XzmSyzkXC9tT6k4ELz9GejE3NJvIwO67XxapY1B9+FsHmHiUY
         CIljGFvDMActb9dJDHZDiD6jMDqoJNOLRvELw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731565794; x=1732170594;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1U1d47krDEIIdDqbZ0ejinn2L3sss3M6fc+t7cgpMg=;
        b=ayKmRhJ07/Z1R/g5/NeDxMTfsqQvUZFXiKtQjX0Td/jrZFgqZoSUn49fXOhHrvu1cH
         sJBZ35xtcJPliH1rjxzePqjnSzD0yQyzD0vmvvaj8coQY28IkmlYkeSvV3XQv+ta5URU
         P8CB6H+g3SajozhboD29kNxSjCgeo1koQZnHoBDzMs+iQtpZAQXHV/D49ZqjNe+BVEyC
         nhtwLKATRAZA8PRfHjPOJBCCFA/QPW9u0i+VPZTjXgAJJEnBryfR/kcCitUeaSViSGuX
         u5YCS/b5cYmX8FzF05gAnPKhV7ZxQ2zcuplczF+FbrMBc/OX7ixvhUCbwZF2y3ko6Lue
         tQgw==
X-Forwarded-Encrypted: i=1; AJvYcCV3hmC2c39EA7urbXzUl+jjhVK2N8zG86sfp9oX5USDeV9JHr5ZcjXwiXTxGCdZQu6xslYjdx4q/shzGVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6VxrbeZqmeZq23T0NtVLGL7bi9fSp/dYo18IO4RGp/NwqnjLf
	QblAwwM+X/RVrSZac01QgEPFeQJWlcXjkfYLGsGVW03L/EzrQzpH/L88bqfAdV8=
X-Google-Smtp-Source: AGHT+IEwKpd9ZK69/Lrrv6KF9AavgRm3fpHJJ9DYUNlx4ODRs/7h6HAJLacjxS3Wq18rSX5qKX82EQ==
X-Received: by 2002:a17:90b:2747:b0:2e2:cf5c:8ee3 with SMTP id 98e67ed59e1d1-2e9b17138bcmr33101700a91.10.1731565793945;
        Wed, 13 Nov 2024 22:29:53 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea024a4b49sm635461a91.26.2024.11.13.22.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 22:29:53 -0800 (PST)
Date: Wed, 13 Nov 2024 22:29:50 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	mkarsten@uwaterloo.ca, "David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [net v2 0/2] Fix rcu_read_lock issues in netdev-genl
Message-ID: <ZzWY3iAbgWEDcQzV@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, mkarsten@uwaterloo.ca,
	"David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Simon Horman <horms@kernel.org>
References: <20241113021755.11125-1-jdamato@fastly.com>
 <20241113184735.28416e41@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113184735.28416e41@kernel.org>

On Wed, Nov 13, 2024 at 06:47:35PM -0800, Jakub Kicinski wrote:
> On Wed, 13 Nov 2024 02:17:50 +0000 Joe Damato wrote:
> > base-commit: a58f00ed24b849d449f7134fd5d86f07090fe2f5
> 
> which is a net-next commit.. please rebase on net

I thought I asked about this in the previous thread, but I probably
wasn't clear with my question.

Let me try again:

Patch 1 will apply to net and is a fixes and CC's stable, and fixes
a similar issue to the one Paolo reported, not the exact same path,
though.

Patch 2 will not apply to net, because the code it fixes is not in
net yet. This fixes the splat Paolo reported.

So... back to the question in the cover letter from the RFC :) I
suppose the right thing to do is split the series:

- Rebase patch 1 on net (it applies as is) and send it on its own
- Send patch 2 on its own against net-next

Or... something else ?

