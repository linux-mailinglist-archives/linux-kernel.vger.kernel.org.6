Return-Path: <linux-kernel+bounces-221868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DA190F9D3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1AEB1C217DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 23:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF7915B548;
	Wed, 19 Jun 2024 23:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ar2S47wb"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A0EF9E8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718840497; cv=none; b=MtrrueZf6F/DgeB4CK5RhZl4XZ1vZbW7t/+ZSR1dv8ocGegqClnDVqx3h9gefT//yF+b4rsT5X5dfxCYs0DVQ2iyCWlTjKrTXxDmPJzmfSHYboAzpyznMuvxWLIQjWmy4C6CMlH3esvLMHFdWnMAAecrWgJQl0irsoGP8cSOUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718840497; c=relaxed/simple;
	bh=5M1DMqBlnYVPlq0gBNHs9DY74jBPxkdWmEYhs1qccEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u39ZHp6kjUciA7aKYoqZbqA9etsQ9fHXeBMQ7oS/Vw2eewV0Z2QgL6bTcKxLH/1FrvjAjrPwB5rO1HpqfOdCQOfiM/Azztf/5Of4AlCysDCEs20UejDFaAwavloGsuNA+MtrleWPQ7ez/kFFaHXFOFsTpjRbxs09npYjepEI72s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ar2S47wb; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c72becd4fdso314953a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718840496; x=1719445296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0keBuP7WcJHXk0McVAgIzARo8mUrjAQPWgU72CE0fsY=;
        b=ar2S47wbi7Z0pSHHJ/d+Kfdn1XQJ786mSFt/xq+UmeZv9OjzqlQ/FEjRUbU5R6DL8A
         H6DLVyxUwLauUC9dcprwsATJT6R/Xs2IDFRX4kQii0pB6w0QGAaA/JB965ortDv6cQXq
         qt8T68YAOEYubB+PGrIAl5uqttANyrhS4Z4+VOO1ThDcfzhINZm8XPTfFmh8tUFw5K/I
         OoIBJiEbPCFjZ2vG+SUOsj/R2zICy+UwmY+pn5PXaMWRhkALB4NryIxr6+dct+A+3Xek
         IsVG/guf4TZchlGmI4lGOUOgpzb+iPDgVTYhbznj5Oupz/K7oPo6iBsj88tV2g2JEPaO
         saBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718840496; x=1719445296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0keBuP7WcJHXk0McVAgIzARo8mUrjAQPWgU72CE0fsY=;
        b=L5aANt3f1x7AYZK7OGfkIK7vmux3k3r25GNr2GVMccutMUpB544xE70Oz799t1dNhI
         nAI6wFDsj20ANju4bFqPQss47bWJ9fcgdsJuOyblFqvNVHF6GtKXSJqEbSGxZBax5hrK
         Ah1blbDXS44jhQUCrv4bg6u9YN5jbTEatfLzOWknaACQVDWpT0WOb4+eu9j8obX/M9fW
         2Tn41J+bxvCESNWhTKMD+iNUwm+85jqrY+GYSttCeADLa/2XHBjmzHbxDAXF5yUjdU3+
         wXQPCywmkMaQ+IM6slv/8VbiAEYHKq19r31IchABQUC/usZ5wzi0eqwv+MU3WQ/FmKqI
         iPzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs0/rcYNF2e1xPYe3MkzclxlqxQyjBkczvXcAO4bIbIrxO/1rxO8ncROprFw55y7xtVRiYAr1tiK9nIOELTMlSIvoyiMicH++jMkYz
X-Gm-Message-State: AOJu0YyTkfo5rzD57a7hrWh0EnHHe80eMxJHrLDMxXHIkB88yvnEZdZc
	xHIVVWvFqgdrv5HccoYSZq10iQxKViPwdkN8nj5LFCRwQjYYPFRnlVCeX5ZvA9F/bfZL6R7SxPx
	xCA==
X-Google-Smtp-Source: AGHT+IFZAS0GNQpPXJKmJsAJOHjI2xJa/GQSJnG1uqCBLSne/K3Igo4Iq+YLUDzCk+PG0cVHPzhUYw==
X-Received: by 2002:a17:90a:ea83:b0:2c3:c80:9ac8 with SMTP id 98e67ed59e1d1-2c7b59f0c7emr4004627a91.9.1718840495481;
        Wed, 19 Jun 2024 16:41:35 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c70aa25553sm1780658a91.0.2024.06.19.16.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 16:41:33 -0700 (PDT)
Date: Wed, 19 Jun 2024 23:41:28 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v3] binder_alloc: Replace kcalloc with kvcalloc to
 mitigate OOM issues
Message-ID: <ZnNsqBNeXnyzhtZ5@google.com>
References: <20240614040930.11119-1-liulei.rjpt@vivo.com>
 <ZmyOJJmA7h6sZ_8A@google.com>
 <c46a07f5-f504-4c6f-af54-cfa00f987ce3@vivo.com>
 <ZnCDvpFveS6X0a1g@google.com>
 <32e0c2ea-6035-4ec9-b99c-e6b686f04cf3@vivo.com>
 <ZnEO8X-7pjeTFTur@google.com>
 <239d2936-8fae-4538-8621-b07c09918df9@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <239d2936-8fae-4538-8621-b07c09918df9@vivo.com>

On Wed, Jun 19, 2024 at 04:44:07PM +0800, Lei Liu wrote:
> We used the "adb shell stop" command to retest the data.
> 
> Now, the test data for kmalloc and vmalloc are basically consistent.

Ok, this matches my observations too.

> Can I prepare the V4 version of the patch now? Do I need to modify anything
> else in the V4 version, in addition to addressing the following two points?
> 
> 1.Shorten the "backtrace" in the commit message.
> 
> 2.Modify the code indentation to comply with the community's code style
> requirements.

Yeap, that would be all. Thanks.

Carlos Llamas

