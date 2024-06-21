Return-Path: <linux-kernel+bounces-225017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 350DD912A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B7D1C22494
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F2C15B997;
	Fri, 21 Jun 2024 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4jAybho"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ECD15B15F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984901; cv=none; b=Mp6ViQKuQJ1IkOlK+SujjcDBuUEFyaY1wx1oTdNJv4CEXlL8NELW7746woa4nosWyZVZogcDr30E7NFbhmPbJB92y7YLGOqa9p+tvrt00X1xUbhLiLPzwHxkS9y1sQumqHnpj6Lhv2NXw7uCKNHgj0Du5jg8JclEp0HvIsYZYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984901; c=relaxed/simple;
	bh=4D6lAdJBRL160ae65uU1wV1D+aQ8Kav3gtLT9fu1DVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2BvT2d0L9WjQGySDFcUqpoOZl2aFNgwTJERHxNT4wopbiA4WdTfmb/ruWaKlMuth0kQeMsOQQdXDn7QOOPZZj5SQKR7nwyBke6zRusy/YQHWJUz2v33bXDOtapfVT8NHcbIJ14GZvq3jcSzeFQnrp2NER6JFhERmscFOreOr4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G4jAybho; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-424720e73e0so20446685e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718984898; x=1719589698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeYCibzE1FMc2+yjflvUxrtJIB+urVCuXOvaaTvmc2o=;
        b=G4jAybhontNJ9IQUlxLsWftAcpvI+HnTKwJ7p6je9EX2EVJstg3ljQtiNRnmQIsp81
         Z7C8mBCju7jbTfhmu/7CoyooZzaq2vxaD58BcCpyD70TY8pvz1Z3YbWusILFCtpV772+
         8N8mZaq8ruTChvCVVttVJGYEIJOUzRcNWABwE21xiF2h+qtvCBIKfQ1Jia6swjRni7Iz
         ENw499jBYGv23ES91KRS2yKNgiCF0cKrfVELOrb005X9XqS/Qo3KA5sKxrD1LJAoZT4R
         QDKm5jqb9bOLO6fwNuli8IBkFtWW2hP2OIkO5qXn5RxOv4uUK3jnYL+qFibw1WwzrBbE
         USaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718984898; x=1719589698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeYCibzE1FMc2+yjflvUxrtJIB+urVCuXOvaaTvmc2o=;
        b=RPM8N8z+qyWvjq95sRQJyzGE21BAvBflvbA+xOoh2xpZpYU/sdJXtDFZGrwJ9d9Yrd
         cVu4humgvJA6E3/soGzxu5+22p5Q7VF1A9QmOb7xfKH6L1u/X3dCiPJEMdxnlJ8C1nZi
         0cUrXLgrKIneknqW/vr1EVCIfj0TGjpEsj6MKV8MoCLHvDA0GYRX7y4Vvl+9wahgwTcR
         j22H8zbi3g2vrI/8eNdje4yviHeUdNc8+uD8dgWCC3wkxTfL3/vtct/ghqyunsDt9008
         b7VSWzkrRulLY8heYewQYSFsNBQRK7BhcVNMBb/iSb9nlLEwLqP6/G3oWoCzu+A4jhpz
         HIBA==
X-Forwarded-Encrypted: i=1; AJvYcCWNeVNiqbJhGpU5lC2POVGJZE422zhqlRdFR2voDob0An3EuwikEb3EXA6rTGq4iY7GgcC+pZ1Qw6Ff7wNJXO8VcBT6OWhW0KbJey3Y
X-Gm-Message-State: AOJu0YzNxSyXoyOYHrlP4qlZ9pXwKxD21nCNpoCNp8QtHRU+rFyR4uRu
	lTei+PBGI1BIQwMK2UmBfztnPY5tOw8krqHivha5rjghNI/gMhfSKdVU88pONM0=
X-Google-Smtp-Source: AGHT+IFf5NTkDyCSPgZQfUPuBtU1jcsGWI2tWgppmjl9Td6O0N5SvqxpaFGGYxUOcuq3uZUTigxzdQ==
X-Received: by 2002:a05:600c:3549:b0:421:7e0c:f876 with SMTP id 5b1f17b1804b1-424752a8e97mr63390855e9.41.1718984897902;
        Fri, 21 Jun 2024 08:48:17 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0be9fasm71314525e9.16.2024.06.21.08.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 08:48:17 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	John Ogness <john.ogness@linutronix.de>,
	Justin Stitt <justinstitt@google.com>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: Use the passed prompt in kdb_position_cursor()
Date: Fri, 21 Jun 2024 16:47:51 +0100
Message-ID: <171898481989.314245.7629196450962213270.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528071144.1.I0feb49839c6b6f4f2c4bf34764f5e95de3f55a66@changeid>
References: <20240528071144.1.I0feb49839c6b6f4f2c4bf34764f5e95de3f55a66@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 28 May 2024 07:11:48 -0700, Douglas Anderson wrote:
> The function kdb_position_cursor() takes in a "prompt" parameter but
> never uses it. This doesn't _really_ matter since all current callers
> of the function pass the same value and it's a global variable, but
> it's a bit ugly. Let's clean it up.
> 
> Found by code inspection. This patch is expected to functionally be a
> no-op.
> 
> [...]

Applied, thanks!

[1/1] kdb: Use the passed prompt in kdb_position_cursor()
      commit: e2e821095949cde46256034975a90f88626a2a73

Best regards,
-- 
Daniel Thompson <daniel.thompson@linaro.org>

