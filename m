Return-Path: <linux-kernel+bounces-561216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7034A60EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 776317A6179
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AEF1F4739;
	Fri, 14 Mar 2025 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJsjKuBv"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8633E1DDA33
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948285; cv=none; b=OLWcxw61Ut2znVNKFh7m9eR7Aq3LSWcMW3B0kcxe7RQRDn5er8AnmmN1dh/zXfdPukypXOcBeYAgUGvuUExNweiNbk4xJQ7rHMtQ3W/iaEqOUqaVRQ4h5l4SXzeLtwpos0nAfnI4NKgeL2khw70HrayPUOq64wLMf9RUCx1pj/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948285; c=relaxed/simple;
	bh=nNTlIP64VWuaxH6vlQJigqC7wOX/ArX0l0vWy7DI/vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhny99S3I5/zML4ltaCpSfgDPxhpzPBiUyArrQ02LH7BxTAVjXZfjF5C91NRoGCsR/jmUWtV7ZRxTZWiOyqzMWT5EdXx2UYEPY76kDiWsHVOpwx8NX+lHBohMEpMXyyuEhkU66m/KQsCsXImLSdGoD/C5uB0gWL/SPz/I/K7FgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HJsjKuBv; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-307325f2436so18728221fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741948282; x=1742553082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNTlIP64VWuaxH6vlQJigqC7wOX/ArX0l0vWy7DI/vI=;
        b=HJsjKuBvRJuaQTAFz5gSufDxtM48jqo9Zwi7A2mCJEGkyY0Iy72vsyvGtqPb+0DqUB
         7yJBjM5D73OaBwOK+vlYr3f0CfleUw9N0TWZC190rgoLpAyrwKC7UltJ8eZzMtlJ77Cu
         PWkvfGUVsNqPmPyVumncXhdUXW+5GtT4kTHTq5/RVzJLkPRYXIc/ceeQksT6QEmqLjKL
         ci8IvDmgg2lND/QLgQJquIcAOz03uD8dILAN5OjHx5fWv98UZ+LScUh/4gttKZMvQjUl
         yhSnKW7JeV9PzxECod69dPKJC5sBpU8elhuyManjQQ59PjF+1clfxSwsd7S7NZ41w6qD
         3k0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741948282; x=1742553082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNTlIP64VWuaxH6vlQJigqC7wOX/ArX0l0vWy7DI/vI=;
        b=VwZdQGxR1xL56JLk37NZkSE6kfMuXpb/hKgzZgMFQbUIy9jxYM5R3NdaYn8nwzsIEk
         OwAALCrKEisvc63yE0x5joCPUiYaRFAfxYUtcwEKOvDRaUYk68IZg50iDpx3Fx4vbQvm
         T2Uq1k5iHt9RbcREfxvIWU3dYf/qTyHU2iFWJ+qpfpzutxkdaZbUtXISuQHVz7kDl5vB
         7GPXAUrBBeCmSIgO0khQrkBMHa+bNBY+bZHG0JFtI+QbTMei7xeoKJSkgM3hqY3FZxTN
         EdsUS8WvcDNlJ4fOYw6hWjXK10RClpB7IA3OACTjSwB8lMbLs7tziEhimzhhcTEUNqtG
         ruhA==
X-Forwarded-Encrypted: i=1; AJvYcCUmwf6W1Rp3fpcBnEseWLHFnffykhyHc9unvgUGDlWPfrntS95N8vOLGXSlB73VXSUBPMTmMAzguxsjMQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt7Rpm1ttPEv4PE7SUPqObo8NU+9Fwt1EhQsxB93iQktaHOc7O
	ecGq9/3602WhImBUJkwTufioSLLKjgHZOGDrZZ8SCFZ8qNheRChtFhYTBXk3SE74p1dlxMGhjEi
	E0V0joNKOMCsvZYskck+tKImJWJl6YnNZkJ5q2g==
X-Gm-Gg: ASbGncumMJ5anwDzQh1SVCp5tWjq/J5OhK6a7UsWYDG0TlslyOxR3zrHA2M6oV8YNcE
	CfGeZRybqcIzSv+nq1Z9WRg6WjcRGh35HhYN2178qKVAkDQ8B25QDzgmsRx/YljqEqGHcJljXp4
	jNfibR6nvixWhMYytmYLVSxXbCO+cBUPm+Hw==
X-Google-Smtp-Source: AGHT+IHHJVLG78L/tK6Q3XLixMJoXbS1n8+RbbB0s2hgbtfLNENuP47sykuixt2xNZY8ET4FhMdKzfG1ly56I7GxcgI=
X-Received: by 2002:a05:6512:6cc:b0:549:7145:5d25 with SMTP id
 2adb3069b0e04-549c396e1f1mr648317e87.34.1741948281686; Fri, 14 Mar 2025
 03:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310222346.work.810-kees@kernel.org>
In-Reply-To: <20250310222346.work.810-kees@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:31:09 +0100
X-Gm-Features: AQ5f1JpQ5MbaMz7xgIgPNXa2CMGzdO17pTnCnXzZL4yUASvYJyCNKkw0MADQ8EQ
Message-ID: <CACRpkdbUk8bVWLPwVRq0qzaKRC80=bV1Wd01h+5xfH1O7-BVaQ@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: ak8974: Add __nonstring annotations
 for unterminated strings
To: Kees Cook <kees@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 11:23=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:

> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to and correctly identify the char array as "not a C
> string" and thereby eliminate the warning.
>
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D117178 [1]
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Kees Cook <kees@kernel.org>

Fair enough,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

