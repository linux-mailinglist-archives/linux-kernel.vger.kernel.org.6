Return-Path: <linux-kernel+bounces-319929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C579703E2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 21:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81096B231F2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 19:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2C8163AA7;
	Sat,  7 Sep 2024 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzKZo46g"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9001DDC9
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725736593; cv=none; b=CRe9NgijThW6bg6bNnoldafXNJTGgNDGVUxBBmM7p6GXok4sJoD3RtObObun/vWU/5F5E41eDPiJLtsoDnymuE6NwB7/PRKB3OFwN6WEEUO1zkzU87wP0dBp3sLdTrrHUWGRIddvoZ3l8BHVJyX9T7FBUnwGvGvAAplgqeRI5Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725736593; c=relaxed/simple;
	bh=i8qsTRwaPWApL98hwOPuHqqVJYXK26fqhn6JPQ2H/HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeYWfTjM441uUCHnZMporlPAzc/zhAoChkUthAmp8MEdoOo6ovfMVDKyB31SJfePCsoeeG3pBMXz6/XbamyChLE2GEcFU70H3N/EpGj9O7yv5Ol6Sg7EbS/MjQW+MR7CpevUDC5R6IfI0gNtJuJFCj7LuTMIHkookCVs1NDoEJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzKZo46g; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7d50e7a3652so1744377a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 12:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725736591; x=1726341391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KVvIq9cbRzgUomviOr5pfKJ5huC/3mV8XHpAjftGdTU=;
        b=KzKZo46gHkkkk0yFqX3lH3nH2adqh5QR3brbm4cDmNVDuf6Fdbe2hnMoqAkJmSjY4D
         doBuhgQLmSJxiRjXuXj4Iw4wqgKzPSP44v0JXhcQ+geFe2VEWg/4/BryvzG/HN2dlMTW
         zY9cAAlkqb2C0a49pLZWWBxqg2s5pDSUfpTV8wj2kuJh57K1yYrWxU3pc1HplgG1XcQH
         Twr7JsuWQx8wHGwtT96BP9A8tPjSdymC0dXU2Reui0XgzRmV5ivfo9E9YYWPH0iyymEX
         4DXdHQQEb8tr6Xs1P5JL+L/Zwu5xL2BAtFikOu4MaBs88VBwx+MaZfGsRWDiabVlk37x
         tOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725736591; x=1726341391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVvIq9cbRzgUomviOr5pfKJ5huC/3mV8XHpAjftGdTU=;
        b=pFUvUVaV24jvW2Xu5spBc/grczbUghG/L20r3QxEWekIvO7ssL7bOGUACXHsF5eQkS
         2zeBfzc8DeZr6UeeD46i/2nnJnfj18sOH58iKTPcCdBmQrTDSivUp5MEOq/YJn9Es67v
         IL67wclfK8OpPJ+teR9HT/upicuZF7Hpj9vCBIZbt8XvdcYXvyWCFbxtT3zMVrtZlNh4
         y8gVzmJjtS8JcZ2lK7dkscrWBVmHh5fKyFqrH2Us14y4vEoHOljtfj0EYvmRAnZCD84/
         2GoXI2Kq6urPfHecytooTyVOcYI/vn/bc4jrGPKl1choCuNADL9TMHf1CgQZvYyRJ0mU
         YJ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8JI0A2VRYRszUl82zdUMRJhP5otPWhTmcSkLigl8fWdSsuI+1k1LV6pjuJa5BqsbsL53pnrDr7ieoUwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHS/+sDj9SKF7f944+UD1wgIc5A+lU65xDl2vfvN9XsNEUJHKw
	DrFYsoEyqVK4lvLcu6mOTG1cfZSnWaULlGLewmfYl5T+w7nLdNi7
X-Google-Smtp-Source: AGHT+IHPvmwOUamhODAghY2fnNUji7in+pa6rUK3uZzkO10N0T61Nm8kcp63YljA29RhpgKHiHqXww==
X-Received: by 2002:a05:6a20:ac44:b0:1ca:ccd1:281e with SMTP id adf61e73a8af0-1cf1d05a9demr6768324637.7.1725736591313;
        Sat, 07 Sep 2024 12:16:31 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58963desm1172521b3a.35.2024.09.07.12.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 12:16:27 -0700 (PDT)
Date: Sun, 8 Sep 2024 03:16:23 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: Mark three functions as __maybe_unused
Message-ID: <Ztymhwn+Nc1GAGnp@visitorckw-System-Product-Name>
References: <20240907021506.4018676-1-Liam.Howlett@oracle.com>
 <f9b2b03b-24b9-49be-825f-7eb1aea59bee@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9b2b03b-24b9-49be-825f-7eb1aea59bee@lucifer.local>

On Sat, Sep 07, 2024 at 07:31:14PM +0100, Lorenzo Stoakes wrote:
> On Fri, Sep 06, 2024 at 10:15:06PM GMT, Liam R. Howlett wrote:
> > People keep trying to remove three functions that are going to be used
> > in a feature that is being developed.  Dropping the functions entirely
> > may end up with people trying to use the bit for other uses, as people
> > have tried in the past.
> >
> > Adding __maybe_unused stops compilers complaining about the unused
> > functions so they can be silently optimised out of the compiled code and
> > people won't try to claim the bit for another use.
> >
> > Link: https://lore.kernel.org/all/20230726080916.17454-2-zhangpeng.00@bytedance.com/
> > Link: https://lore.kernel.org/all/202408310728.S7EE59BN-lkp@intel.com/
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thank you for solving the compilation warning!

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei
> 
> > ---
> >  lib/maple_tree.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index 4f34e50c92b5..20990ecba2dd 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -348,17 +348,17 @@ static inline void *mte_safe_root(const struct maple_enode *node)
> >  	return (void *)((unsigned long)node & ~MAPLE_ROOT_NODE);
> >  }
> >
> > -static inline void *mte_set_full(const struct maple_enode *node)
> > +static inline void __maybe_unused *mte_set_full(const struct maple_enode *node)
> >  {
> >  	return (void *)((unsigned long)node & ~MAPLE_ENODE_NULL);
> >  }
> >
> > -static inline void *mte_clear_full(const struct maple_enode *node)
> > +static inline void __maybe_unused *mte_clear_full(const struct maple_enode *node)
> >  {
> >  	return (void *)((unsigned long)node | MAPLE_ENODE_NULL);
> >  }
> >
> > -static inline bool mte_has_null(const struct maple_enode *node)
> > +static inline bool __maybe_unused mte_has_null(const struct maple_enode *node)
> >  {
> >  	return (unsigned long)node & MAPLE_ENODE_NULL;
> >  }
> > --
> > 2.43.0
> >
> 

