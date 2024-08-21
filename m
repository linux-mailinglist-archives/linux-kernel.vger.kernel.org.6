Return-Path: <linux-kernel+bounces-295999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEB195A41E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0607228290D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F62B1B2539;
	Wed, 21 Aug 2024 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsZVe23Z"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA7A14D28E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724262261; cv=none; b=LAVQQGtSWvTLqeO5jJE+u7qOCiKOMdsMl64Tm38ZI/wIKSUtzWKD3ijTqzr7G3219rPJFAIka19RMsog1WkJZR6MfEUHWvE9FU4Ivc7XcmG79v0jHzuKErRkVbLquq94yc0PBbzvuYJPLMCC0WShZiwtK6aHDbW/jUKA4ekYNF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724262261; c=relaxed/simple;
	bh=vZuf/TdhPtCoAS+kwAyphrQ6cmQScdRjMhuwjtdVcxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIyfhMy2ohuh9eY7gL6sIeQCoiAhoq5HcRoR2jttfTSX05opVHMEkegwtb7U2ZpJ1r/1pHlo5E6yKBd0X4ODYXIOeCjZ0fEXYhLR3HIMlFIAG8m5XnaTMB64KrSioWgGjoIhWYjywneGpSfC0Vg1YSH3CuhGuZ7woZsRLjDRkiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsZVe23Z; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-714287e4083so697344b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724262259; x=1724867059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z1+m9KD3XiEMs9WSy717jFmMmWEo/noGdYnr6WWxjpc=;
        b=KsZVe23ZvOoTfopkA1UFCvuIFxSDnOqv0ETnhHkZuuaC17WBJCriaVvU1P2mjQvv8A
         JKuutLDpSzJOAYrPb9eeaEkCNsMG1oQtF8dUpa4hJ9DD+cu6S/PMxFkY1zoKIhnvf4mh
         lhk/PkaDr8k0IJsQxtZ8NMIVBwXd8vu8ewGni8MRmv8hN0EzPy3SmdQAecHyD1YFgEd6
         1ZzRZNcvTlywpE4ZvuhJ8pnqy86YvAUBsZB0Q/657E2gV6dY4NViIOjdNLq+lNpLnzBG
         tuiR0pD2kESj/uq992ljUzrGANljPCirWWCvp7Nn7ris2zUe0kc4qhjoL9DZEoz4Sfx7
         QWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724262259; x=1724867059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1+m9KD3XiEMs9WSy717jFmMmWEo/noGdYnr6WWxjpc=;
        b=GfnKJoaMBjOZypmK6TXn7XCD5h3xdGXbX9tcJymWNO8z1gfv00556tsHBiBroYxBdK
         0E48y+v9yByaytlJRsVA88yWKkNNWBd7ueAZlfPzGdZy9Lbi8tZMNAKc9bCv3v+sV3G6
         GsWyENq01UjvCVtbPBd1FpsEIKDeSf8QxQ44+0xFeWxNbpDNNFTaoun9mjNTBO8syb7u
         6pcSwkN8NQkSTJ/it8VhGGK1HBe673fIe6/FDcOy7Xi2KLUzZKSKIXFyW+Do5MhV5kAk
         tFVXnVG2jZ0wdfnJ9337dRp0ADK0l+8+H5T8q73o/ev85vJABNbfjT/jr27t/wA6/JL2
         6XZA==
X-Gm-Message-State: AOJu0Yy/izUJjVLlMpSQRA/94vWT5wlqzg+NVv2HSCkEyJApgZG21zyv
	lF4Uc4DYS6oPZyT1IOVaOvhTyzXThguHh2drADJgOZxwNzvWV6s16v2MdX0R
X-Google-Smtp-Source: AGHT+IHE69FJQ5ONIVqz+0CsJWz3ZA53/1dZprx9xuO3HGSavtcPPb65kAeSeMuP5imbuQ98Td3UMg==
X-Received: by 2002:a05:6a00:3d56:b0:714:25aa:e56b with SMTP id d2e1a72fcca58-71425aae5afmr3604457b3a.8.1724262259084;
        Wed, 21 Aug 2024 10:44:19 -0700 (PDT)
Received: from debian ([103.57.173.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7141dfe70c7sm2126954b3a.121.2024.08.21.10.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 10:44:18 -0700 (PDT)
Date: Wed, 21 Aug 2024 23:14:09 +0530
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]The patch fixes the following warning generated by
 running the
Message-ID: <ZsYnadjCVKpR2Thv@debian>
References: <20240821161539.541062-1-sayyad.abid16@gmail.com>
 <df837873-f422-462b-8a88-25c02d4f8cf4@stanley.mountain>
 <ZsYiwZDh3yegyERk@debian>
 <00cc036e-6e12-4c9d-9c97-953c452606f3@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00cc036e-6e12-4c9d-9c97-953c452606f3@stanley.mountain>

On Wed, Aug 21, 2024 at 08:37:26PM +0300, Dan Carpenter wrote:
> On Wed, Aug 21, 2024 at 10:54:17PM +0530, Sayyad Abid wrote:
> > On Wed, Aug 21, 2024 at 07:57:30PM +0300, Dan Carpenter wrote:
> > > Also the subject is not in the correct format.
> > >
> > > regards,
> > > dan carpenter
> > >
> > Noted, I'll keep this in mind from further patches. Also could you please guide
> > to a fairly updated TODO list or somewhere from where I could look for tasks to
> > start. The lists I found in the kernel tree all are too old to be left with any
> > task, I apologise if I am asking a stupid thing.
>
> Please always keep the mailing lists in the CC.
>
> Try searching for KTODO on lore.  Maybe that will produce some useful ideas.
> https://lore.kernel.org/all/?q=KTODO
>
> Try running checkpatch or Smatch on drivers/staging/media/atomisp/
>
> regards,
> dan carpenter
Thank you for mentioning the TODOs. I'll look into the KTODO and checkpatch.
I'll also make sure to keep the list in the cc.

