Return-Path: <linux-kernel+bounces-530395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEEBA432E7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1472189E2FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12F32030A;
	Tue, 25 Feb 2025 02:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJtm0nN4"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE7EEA9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449861; cv=none; b=iexNeWXWiRNTjoNW0OImRwuZiu4ygXZWl68sjqgapWFbTBplXeBULRQ+Ogr9NLgkDOt4hV691ge7s+LuBK6SsyqpXpG2uABGDN//axBx0CNefwUNgF3ks06QCD/3F85CzqJkao9vpqX6rdXbIILNQuV6j90n4cXZXwj9AmOdnSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449861; c=relaxed/simple;
	bh=0Eivcdp+A7pG7wwiVJ5XTGum9UPwd7+I26RVQGXW6BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSLRCm7AR1yjf/ZZxRSQx9EnXTjNyksDEhvquYW2KY6J9bP7zCDAVQiyOFHIJjyVKMXND7Y1AGUO71VksayriC47pKv6a9uAPstsjlMtbTxCocT/wbdhyxOv1p12qqgezhtfjo7+tn67dKaN7STplK1BfZDugQsoAGGXu9gyp7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJtm0nN4; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso7767469a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740449859; x=1741054659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOS0eotP9HgBs5b48mc5ky25x1A/ex4SBF4Q7qRbOvE=;
        b=PJtm0nN4oj+AAoy5n+fLYbRJwNFqQAxUxAsaEBYsL03A+SMb13JPuA0q8erfh3jEEN
         rnkarBssJdlOVZOxS4X13e6kT4EeR64llxPJ8jlCqgxNSBXvA3jWAbSY+qbhjUW9lADz
         UNbKpmMjj0Qy+8h0zkHRHRsIf1aH7JzjnMDaEqqqDTdnXOTd4JX1oo1ATCltJLVMh7Se
         QNV+gZfa/QFo7BGWd35IjCE205AFlbI8hGuvJM2LRSQ3Vv6087VrN2/bgyebJ9gcHqVn
         soHQ5zZ38IA7wpuJMe282HG1m0dkB8Z6lmUK/xqoLUvRp5QMwMV6FMU2FzfZ1nVe3y/C
         zS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740449859; x=1741054659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOS0eotP9HgBs5b48mc5ky25x1A/ex4SBF4Q7qRbOvE=;
        b=RIwZGFdEe/8/jtUNoqCPvE2I+L6cQ60qtkPXOgVY1SAkcKaaUOOOy5ucA3NI2rFbvg
         DXrYY19jp/iv+jt/cLiyr3ubc916OtJa3LObNy1lUaJHt7hZOauvXtI8TjBv/tSbnMIY
         aTspsJGAeOC8O2nY05PeGvDOBZmdqbGPRvWJaHXvbmdXevVGLy3L872QEknDNXMJmcnU
         vIYO6Gbc7NAsVicUkfEUPBwtacXw9agHc7hQpl2kfFiv4iyuyaehPr6EttcIqBxbtGgB
         J97z5sbYun99W0zizWeaS16gUKiE52HbQRomgp9rMJ1vxGBzFNNf+EslvTBPKdph1WUb
         5BYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvUCb75AAF42Os32AYSM0kEMgtX+Cd7P1Bb1YqHAj0Lo1SDh1So2qCizrdO8VoLDPI31yqr5ykVR1YmGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUfCEbvJJtOotKJmW4jV5uSXpMRV7IpPT49PtkTnOixq5EGn2L
	JJCzDBpNwhpUzGyu81LBKO7KNcm/xJxHu6I+8DRWEJlzZJ2b8s3i
X-Gm-Gg: ASbGnctjWPzDh9GT3oT0pL8kp3m4/x8hLwsnj2LqLL/voA1d37FkGL9ORA8YuV3SdwR
	5amEmzG8S81Ng7AVnj54nZ1pyShianWFZnKcw+GxRnaeP4vX0/yWnzgEJm9ElnO4Vm7m5fseD1A
	nEjihYbglPJDSDxdQp+PL9Lg34ga+cfK+YqVXeQDQtZJ49bK7grLz+LtjqzxB60sM5oB4o4FmGJ
	KikjjOEUO+nQRlw3ZhmtKUsHaP5GX53/nBhob8uWUsmqufBW4/sf5NioV95VU13NjgT38e9Jbg4
	ZiGpPhE56Hg40M/SaGyKDE/9164=
X-Google-Smtp-Source: AGHT+IEl0tzqbZ6LdSxSySBPpRv8EfKnmQmZ2fT2AUioQb0SQ5hm7S5RtJ/ur759fUcsFZtrvgN/xw==
X-Received: by 2002:a05:6a21:99aa:b0:1e0:dcc5:164d with SMTP id adf61e73a8af0-1eef3c49154mr32451605637.8.1740449858980;
        Mon, 24 Feb 2025 18:17:38 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:464c:6229:2280:227e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6f7609sm349247b3a.54.2025.02.24.18.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:17:38 -0800 (PST)
Date: Mon, 24 Feb 2025 18:17:36 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH 1/2] Revert "drivers: core: synchronize really_probe()
 and dev_uevent()"
Message-ID: <Z70oQKHjvjutqom5@google.com>
References: <20250220064647.2437048-1-dmitry.torokhov@gmail.com>
 <2025022051-happy-plant-b40b@gregkh>
 <9232C7B6-627B-43F9-AD5C-1EA4BB69E40D@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9232C7B6-627B-43F9-AD5C-1EA4BB69E40D@gmail.com>

On Wed, Feb 19, 2025 at 11:22:25PM -0800, Dmitry Torokhov wrote:
> On February 19, 2025 11:13:00 PM PST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >On Wed, Feb 19, 2025 at 10:46:44PM -0800, Dmitry Torokhov wrote:
> >> This reverts commit c0a40097f0bc81deafc15f9195d1fb54595cd6d0.
> >> 
> >> Probing a device can take arbitrary long time. In the field we observed
> >> that, for example, probing a bad micro-SD cards in an external USB card
> >> reader (or maybe cards were good but cables were flaky) sometimes takes
> >> longer than 2 minutes due to multiple retries at various levels of the
> >> stack. We can not block uevent_show() method for that long because udev
> >> is reading that attribute very often and that blocks udev and interferes
> >> with booting of the system.
> >> 
> >> The change that introduced locking was concerned with dev_uevent()
> >> racing with unbinding the driver. However we can handle it without
> >> locking (which will be done in subsequent patch).
> >
> >So shouldn't we take the second patch first to prevent any issues here?
> 
> I think the potential for the NULL dereference is extremely small, we
> lived with it for many years. But if you prefer the patches can be
> swapped.

Greg, I was looking at this again and I do not think it makes sense to
swap the patches, as then explanation and justification makes no sense.
So we can either keep it as a straight revert and then address the
driver pointer handling, or combine the 2. What would be your
preference?

I will need to respin to address Rafael's comment anyways.

Thanks.

-- 
Dmitry

