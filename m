Return-Path: <linux-kernel+bounces-172844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D458BF762
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5131F215FF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE206CDDF;
	Wed,  8 May 2024 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ljWbr07m"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A14B3D96D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154189; cv=none; b=Jh4RRNJ6b26XlkF3EZmgVgTASYrie4vYMv33bqUACd3/mfauw9ShpeiArVe73U3ZmO127A4aqLPJ4/inJNVH+cwn7sgbTzt+yz6NZEH64TTZLUERs6e3UP+DvnrBmc7mW4xifhUSDFWOS3LhRwaHAwa66CXNKiKA9KAaI4xhzvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154189; c=relaxed/simple;
	bh=hDeQFtkx2/GZWAyhU45hOXqXPx7AQ4PlzH3dLzTmmhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqVt71+C8Km/lN4vYBrgZbQIleV2GaiimXjNgrXqwtUJ+3Ejy9gtJppYkC4kedI5CmH55qBOkqjM9Io5d6QgFOqpI3gEfrgHxfWD/pY2fciZ0x2gANG3glTr68Ry4sXXbJQx0asLXk01zz8GsqTx3pejMLg0d3qwsTzCb9OJ7nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ljWbr07m; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ec92e355bfso37806075ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154188; x=1715758988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pc1W4eW+IgwZK6Yej3y72PjDL5L1vGMvHneuHzMgAeM=;
        b=ljWbr07mbbzjqy4wB9J3yvLXGCy/PHs2O0wksf0X0GajRo+fKM99p/qaroeUZk+9fY
         8oRKXoBpQyuhio7thDEgSdrpCFDSy3JqOob+/SpVSbyv3SBjJ3NA50kVnLHqcxXVoSze
         V0Nw3ARV/J3bf4O5b/1pImxXRNBRJoO4tcMu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154188; x=1715758988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pc1W4eW+IgwZK6Yej3y72PjDL5L1vGMvHneuHzMgAeM=;
        b=aN1ZGzOaS3WlFoEk+HOtcI8hF/KGg3c0poFyTPE4NZ6Urrk9ZcS22cEI5/V+Ns0d2t
         IWSV2i34SCUmRlL7OLgkyxx1fbE5JF2V6LBTbThhJoOoNt6DY2HRFHc2+3p6P97Qqw8f
         bvSDrxWnIWwFInqs+ygX3mgZOsE/LGi+uMdgyjrOIPjCYbgb/+a2wbIZQDGhrXULBXNV
         ZOYswAsxaYYNelxqsJTVxfj4wi4DE5iXZBW5/Z44x1kcrVr9Nn22CABpbh0xAkWElYVu
         jYVB1kfy7G2Vwi4BCmEMGsI6e5XK0xaVyKw9ZVuhUVgcTWElEW6LPa4nSp1bjrwqPcVE
         awrw==
X-Forwarded-Encrypted: i=1; AJvYcCU7ige3rr17EiC/HQXxMYYVfm9zxkyfKuEEpiSfeSRH5Y5aXogRWe9UuIvYJteOzGGKoJuM8/7ySFYRPKonrngUuI2Ina9OYjbggRim
X-Gm-Message-State: AOJu0Ywjn1DO18GQLO3WePDHAquSMdBznI+t/YNzvic1jozHutf5Fdxa
	8fDMPyJZ5+tG/vTAA0SJAMQhQPsQ90aCdQSSKF1C4oqfv7swdljIS7bVkQ2l3Q==
X-Google-Smtp-Source: AGHT+IFL32HmWNS8P+8r6e24kOmVtobiXguS0Hhjw9CbOf5gzBCKsq5cz5LfIJAXntccOTEvKcZsUg==
X-Received: by 2002:a17:903:228f:b0:1e8:a63b:d427 with SMTP id d9443c01a7336-1eeb0791c73mr21694205ad.49.1715154187903;
        Wed, 08 May 2024 00:43:07 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d11-20020a170903208b00b001e7b8c21ebesm11156863plc.225.2024.05.08.00.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:43:07 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Alexey Dobriyan <adobriyan@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Sven Eckelmann <sven@narfation.org>,
	Erick Archer <erick.archer@outlook.com>
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] uapi: stddef.h: Provide UAPI macros for __counted_by_{le, be}
Date: Wed,  8 May 2024 00:43:04 -0700
Message-Id: <171515418204.39234.18138383965654677988.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <AS8PR02MB72372E45071E8821C07236F78BE42@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB72372E45071E8821C07236F78BE42@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 07 May 2024 19:33:18 +0200, Erick Archer wrote:
> This commit can be considered an addition to commit ca7e324e8ad3
> ("compiler_types: add Endianness-dependent __counted_by_{le,be}") [1].
> 
> In the commit referenced above the __counted_by_{le,be}() attributes
> were defined based on platform's endianness with the goal to that the
> structures contain flexible arrays at the end, and the counter for,
> can be annotated with these attributes.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] uapi: stddef.h: Provide UAPI macros for __counted_by_{le, be}
      https://git.kernel.org/kees/c/6d305cbef1aa

Take care,

-- 
Kees Cook


