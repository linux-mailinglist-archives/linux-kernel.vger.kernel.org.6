Return-Path: <linux-kernel+bounces-253356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F041932006
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535241C20D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E85171B6;
	Tue, 16 Jul 2024 05:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PsU7XA/I"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD256E556
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721107452; cv=none; b=P4bIyX2OZbemBqbUjweCfLMMQn/Skhm/zyUH+j2v5i7AVo6q1JlJvb2tXuvxaMwegPVp+kO1FpWGvovI0TfS+cKd3hR/RTyiE2ToogKv8n9PEhyImTKx4QmieJ8yGUF2SbiNGlMScUzJe7s5iSoKDNBAjtXk19fk+ycfgeO3y2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721107452; c=relaxed/simple;
	bh=p6AnIFEaI8+eVR2rhWrGeDZ6/n6RxzME6epo8WhImrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvO1TOhEOEKGYjeAXAfqWYFtN3HVViUfnwrS2s3WCidcbqGuWkFp6yVv1wd1wzLfXGNJdM6PaYY30Dn1B/3WCsOLJyEw9xb+wkPRlTtVSsCW+rm5Z5b95Fjp2FaSnlldIXvkfL7pbUM7iePjNXeWkErqOcZMt13BCn2nfMFwHos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PsU7XA/I; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70af81e8439so4192183b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 22:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721107450; x=1721712250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C9B9JN+Ua/c3Zt8bcV7ixZ6TapYKuSKmFx3Lv0YmcDA=;
        b=PsU7XA/IifmoI66+Wxe5gQEzyDejVuRde+HoM/w84bxW1IO0ZcR3RiNxx085Ql4E4i
         1kpNCv9nnrliuS2feSXo9+sI7rwex0XJAtV/bXfTUq0r62EeB+NyW+WlZjj/itqA5rPK
         3CJ9qPijC7gj3yhLjp7qwKMb3FQ8+3c470GPLWcZQR5dzNFJvvndsP4/eek4OfrbLB+h
         iip/TTP/Yredk85TVzJNGsmrHteQ0iF3Zkxl0QJvHDsggZHQYhlWzj03CIYoz//DvCF5
         evZAcA0BF/6fcRscuQuO0bXF+3BLCeBg/5usAtTYuZVOG6QsfPHLz47bcdNWge1hWUct
         QMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721107450; x=1721712250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9B9JN+Ua/c3Zt8bcV7ixZ6TapYKuSKmFx3Lv0YmcDA=;
        b=mmgURc12x71aHNHkMuqf4OMwqYwDqw4UvM4SID9/nvxSj8plnPd02HAqnfsAslVB5X
         dMmPGVRSr9k3e1RjLEqwzAAMD3h2JnXppMgtdxGep6miyDGaJNl9BKAl94NCkCYu3Rg+
         dB6zQ23HYKzi8HOmjGIyrJT/EYg1Ld2cc+oaTdE5bMGWusVy6uDFO+uTrHvmd8AysZwW
         xZstylaOWqeGuejp8U0S74aevDgQYAYGHmTH8Fj9W42bRyyPthLbNqIL6oGbOniU3J42
         eNuzWN8mB2eevnU4CZex7UVfQTkSxGWOQWKKi1BU5wMRlsbYJ2lDvYFmmQYVvpv5ivzn
         BBuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXs2fSTks507cLfsTO3tEnLn6O5zACq7CDQItrE6vJud+LkKRMdzY9Ff2dKZ3qxuEVnkd6uZ7G5/jcep2pA4yVFNnsCyihI6oucUNv
X-Gm-Message-State: AOJu0Yy5l8L1SlD+g3yku0riLGYDLWfaEtw52M7KSD/OyeZrFh3rmO2C
	OZ6nz9R4i5Ly8ku+M3gH9cLGrFgegB8KwTqJgmKfcl9l51NcwgEX0jhChNXzRw==
X-Google-Smtp-Source: AGHT+IEc20xCihgHc6qJL6l5AYhxDEX0rMlncPQrK1V5XHMLXVjhlQmd2p6P4A6WScUNDzEVCN4GeQ==
X-Received: by 2002:a05:6a00:10c5:b0:706:4889:960d with SMTP id d2e1a72fcca58-70c1fbdef6cmr1761789b3a.16.1721107449631;
        Mon, 15 Jul 2024 22:24:09 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e39736d12sm4168214a12.78.2024.07.15.22.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 22:24:09 -0700 (PDT)
Date: Tue, 16 Jul 2024 05:24:05 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Joe Perches <joe@perches.com>
Cc: Nam Cao <namcao@linutronix.de>, apw@canonical.com,
	dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] checkpatch: add "Reported-and-tested-by:" tag
Message-ID: <ZpYD9dDKYYK0BIA7@google.com>
References: <20240419222818.50719-1-namcao@linutronix.de>
 <22344b13affea741ee41b0acb3c62884aac3e1bb.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22344b13affea741ee41b0acb3c62884aac3e1bb.camel@perches.com>

On Sat, Apr 20, 2024 at 09:22:45AM -0700, Joe Perches wrote:
> On Sat, 2024-04-20 at 00:28 +0200, Nam Cao wrote:
> > The tag "Reported-and-tested-by:" is used all the time. Add this tag.
> 
> General nack:
> 
> I think that combined tags should be avoided
> 
> see:
> 
> Documentation/process/maintainer-tip.rst:Please do not use combined tags, e.g. ``Reported-and-tested-by``, as
> Documentation/process/maintainer-tip.rst-they just complicate automated extraction of tags.
> 

If combined tags are discouraged then syzbot should perhaps stop
suggesting the `Reported-and-tested-by:` tag? I would imagine this not
only applies to the tip tree and that other maintainers agree with not
using combined tags.

FWIW, this tag in particular though is quite popular:
$ git log --grep '^Reported-and-tested-by: ' origin/master |wc -l
82056

--
Carlos Llamas

