Return-Path: <linux-kernel+bounces-536381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CE2A47EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C982165177
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB51D22F14C;
	Thu, 27 Feb 2025 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvlUI9GB"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA122DFAE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662479; cv=none; b=FtNAu4N0LGF4raabykc1pn1sL/IgI+vC3rBcWpHcBDqnGR7slyL4tuRYWxurnSK1PVEEIrTnufvU/yt1ABLAV/JbZ2DNyUqz1uaI6rwTtQib0wppCBQTbG10s9ccNLxxOBQqLN/kmYVWKmawZDWuOosW0xuI10CXYAUfHnorDpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662479; c=relaxed/simple;
	bh=kUSzUBUAyxF7i3mrcfWTZZqbkTkJVFHYoNL3e6Ied8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W29oG5JpBN+gtr8owwX+evyrnRxJ5xM9XQkTFBKvZ9IE2HWSrVLleNUAaZJFRQK6/DnTnUse3VIKt0pzadHxxZjn0QfF4dYUCOtrIQTz6RlSxJja3DiYZ1InMx94IikLubE4Gwm7dMdZe/4lPygakhSoQXx5uYpCLdcReOL9+rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvlUI9GB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-219f8263ae0so15653965ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740662477; x=1741267277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=55K5kjOPTxvO+l1KnLtQ7O5eQyakwPI/LezJskOirHQ=;
        b=mvlUI9GBOsAQ4HYKxYSre4oAw6MLXkvFafvLmO3a6lziSjDW6KjBkkJ3NrJB5WkC8Z
         IwhC49PH6S5dL6fCmBsDQeAC9SZYPjDk344jda7EY1b+gir1M9QqBCFnzQc5LjNF9AvV
         /KTUJxySmHg/eKXZZ3TFWwb+eXPBt8kiB4LDOQMAq8V6gt0FlYDBk1ANVFdBgwYfoUvb
         vQ/bHVAFGbjzGiqSE8RagwhFbwMhxDSFWYRJwmoeR7QFF5/4V4at7+gQo5SNtUU5zLiL
         dpIr7BZ3GDigZ47fZf3qrk9PSCe43SSA/+JFt5Hj8GwfpMhsovsIvV+JGCQ3zCPMv2o8
         G0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740662477; x=1741267277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55K5kjOPTxvO+l1KnLtQ7O5eQyakwPI/LezJskOirHQ=;
        b=STWj1aYqxqNQQX83zgIc90XDIZ/Pg0ZsRaR/fTbEVMmR3dpFrOdsJqAXpfsZBa77m2
         KX0VaAym9KFBUavkDykLVFyqB9CzXFZ+NHb0DIyxtQ1RdJmJJzEmFGX0rr6NX5hZKgyw
         DG1SW5weiQXo+EIzELZ/Wmm+/a3X4Os1Mg8WktMJrGAkJC9KaRIrufjVyhmdbVzhsEkp
         /anMPdBsCaCKDDZCeVbuz880X6KLnS6w5PI824+X/Z/6gAVTdD6I6efmHqFMLmbX/5kA
         NBdQKmyjIfoaZQKT8wr9JBdCAcn/P2xTeFQZ/STaLc5Nuxi8XjlWgUWZGLv4sjxYzY6a
         a5aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD+HgF9G5B/1b4OTTWp3LQvgWfs/lqE8rZ3zO3pL/3Vukh3C3D4cwGS8bqMU1MCdPWErFgf7gEHcexAfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSX2XYjrwACGaTdgB4Saggj9fNh0QpkBAc+XK5cnyrjkiM/foy
	fKQoYVyzwxeb0mDwNNADFU8iIOk70m4vbvSp2b2uquhDUia1aiRT
X-Gm-Gg: ASbGncswnYZtsC7U3+feNxMF1OEou1QuoIgXg/0VMVpK08Pp8lVCWUmyeRLVHkdAXFw
	rzcK541CN4gQVg8sY1JVQa9LIk+Duz2gWedNujMzhyJw+HEDzgewhDQwyf3XmYJATGfCyg0fH2K
	+OVNBc2hVA6e4W/QQ8oy8bYehRQhFnQ+YmDjH/wIXz/ZFupLo2OMFD1NnKV2y20Gbys+iykN6NM
	dyuWxwfBDgvNkZxzRJvrlqDW2QafPEbXK7n4xOj4aDX7SU7ehrCcs4ekEEQqfMl/jCFHbjfWcfm
	ZZlY4niZ4BYGbfT9YzSaSg6le7YD/TuDiJ0E+ItADs2SJsbonliJPA==
X-Google-Smtp-Source: AGHT+IHnLwMDzoq1QG1x+SuGC1XP7H/W80/gJqu3pUnNDU+I8N+Qx1qJM0zHBbpnywwnO/BE3vPE+g==
X-Received: by 2002:a17:902:e80d:b0:220:f5d7:6405 with SMTP id d9443c01a7336-221a0edbfc3mr386746375ad.16.1740662476942;
        Thu, 27 Feb 2025 05:21:16 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050f5a7sm13767315ad.206.2025.02.27.05.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 05:21:16 -0800 (PST)
Date: Thu, 27 Feb 2025 21:21:11 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Yu-Chun Lin <eleanor15x@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/bootflag: Replace open-coded parity calculation with
 parity8()
Message-ID: <Z8Bmx07nPtNNFGUN@visitorckw-System-Product-Name>
References: <20250227125616.2253774-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227125616.2253774-1-ubizjak@gmail.com>

On Thu, Feb 27, 2025 at 01:55:45PM +0100, Uros Bizjak wrote:
> Refactor parity calculations to use the standard parity8() helper. This
> change eliminates redundant implementations and improves code
> efficiency.
> 
> [ubizjak: Updated the patch to apply to the current source.]
> 
> Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Link: https://lore.kernel.org/lkml/20250223164217.2139331-4-visitorckw@gmail.com/

Not sure if the Reviewed-by tag is appropriate here, but FWIW:

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

I'll exclude this patch when sending the v2 parity patch series.
Thanks!

Regards,
Kuan-Wei

