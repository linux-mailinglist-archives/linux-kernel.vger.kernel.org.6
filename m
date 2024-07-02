Return-Path: <linux-kernel+bounces-238238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4B9924750
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1BFAB217C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B781C9EA3;
	Tue,  2 Jul 2024 18:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgUnzBr4"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16971BB69E;
	Tue,  2 Jul 2024 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945107; cv=none; b=G+uOGMLKp8QHRudZ5O5w9+ePS1MtE6aynukPsqbRhHAn+I6vJ+2KxSaaz684OVXnf1LYtnY74Zw3Rnaw+IqsF+sNcjRPa3E8R5fst3QdTb8nFN62hmPHi/Jh88lxsJPHMNsgaSowhPIyCFriW3+6tWi2LHT1z8/70cYIATtYOnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945107; c=relaxed/simple;
	bh=pqDZ1/vCtAwi9zJHezUha0cEU3or+SfAETfpqFIlcKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiUFaztqvXxL5kRCfifB58I+LnChfm2X1MetmrTFewBY4sQ+znHFX672v8pFDU4cg7la8eghaiu1RxGtzJ013GjXJEqxCQ6NFHUlEx5aw4tHxhi3T9WdavatS3ygGerObTL8WWpBKB3fpyAdKOhVPfT3LLiYaHNOD3GAjOYFQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgUnzBr4; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-718b714d362so2522545a12.0;
        Tue, 02 Jul 2024 11:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719945105; x=1720549905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlLp4s8Opxn4iwkcv4P7KdPkWgeRG/lKDgUPmU3V1QQ=;
        b=RgUnzBr4UIhzvfObZVax1OZ+3YLftpobRamKfxd2qIwJKXKRxR1Fl0c1XmTDAUraNo
         Aw6kq5sdxOHvWAg1HcP80uN/bYGduzf6Rsm8oVIDL0tI9Bcz1xKYi3HXnnzdE26zFzIj
         wT6B8Hod5hFOxJ4wIWtqH1/cAsgfyaJfmJl0fGQGtx+kdFFW4GOwHOiLTtWQEcjFSp62
         rSrjac3JjpDuaib7oWjuDIeNUcJLYnBx1Ax6NSfF7B7Azo23K5N4ND9WuUopiazekTFr
         Ve6kKtaxOT8v5LyCvxWTCuMbRI1cWM0o3d9E+1uIqOcGt6tHvZaieg9OsRSJHrSsky8n
         6M5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719945105; x=1720549905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlLp4s8Opxn4iwkcv4P7KdPkWgeRG/lKDgUPmU3V1QQ=;
        b=vf8m7OhVAqNoPiGoW9TBSVWD7/Zr6omOpYhNb+/z5QYJZqZlsF3awNAXl27wDsc0rS
         //gMK5e3ycs7r8J3f7gwktTwmPyZLiH5kUNCzNw4amq41x+SE9cVCB9+rlHQHZ/WB1iT
         lFSCH+T7RhX+7sGAkssxA/FyQt9Onam7tDKe4NF0+2uNmALdd+dvD+/YuTIuNFT2dL9U
         C5WH/hSrNjR1AKlFe9ewQ7nbzkEXHQ3eOQw3yHhMlhbQahf2ICMXfROtQVXeLf1gMtft
         tHFrGMMj81Ed1nLefsMm/p/qG8EO5hIHRj9zrzfMO+i64qMfaYhJ7PHfUFbj4zKptznC
         DAcg==
X-Forwarded-Encrypted: i=1; AJvYcCWq7uEppRf5eHQkFsc4b7maPGWOiMQRJEaDzDnMVEw8y8j+HqALlVXeLGd1mX6SpKOwbzJYCE8K0HVM25d+hnbLjgG+7fkpW+ETnvCZEQmpUL3v5QK8n48V/zqZVk7+yyu5IJ4ZN0JrN0A=
X-Gm-Message-State: AOJu0Yx1/hT6UDW3/eTMznjyLOf8a8fG1WYpPa7RKXQeVOKmvOu8O7X6
	T1/WTVPhGqA5WSEeBZ1xzlQZsSjwQYZm/89D56/0P72tSR5uKCGM
X-Google-Smtp-Source: AGHT+IEodsbzFaBhUZP2e0TTyRETRmeOEJTYER+L06cA3XSX/MkbBPi6iZjM2QpZpmYB0S1qGdQalg==
X-Received: by 2002:a05:6a20:6089:b0:1be:dd1c:a6e3 with SMTP id adf61e73a8af0-1bef6276203mr6736631637.54.1719945104713;
        Tue, 02 Jul 2024 11:31:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac159d8c1sm87509395ad.290.2024.07.02.11.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 11:31:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 2 Jul 2024 11:31:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	Eric Tremblay <etremblay@distech-controls.com>,
	Robert Marko <robert.marko@sartura.hr>,
	Luka Perkov <luka.perkov@sartura.hr>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (tps23861) Constify struct regmap_config
Message-ID: <593b6334-c50c-4812-abf5-30ec05efb739@roeck-us.net>
References: <20240702-hwmon-const-regmap-v1-0-63f6d4765fe0@gmail.com>
 <20240702-hwmon-const-regmap-v1-3-63f6d4765fe0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702-hwmon-const-regmap-v1-3-63f6d4765fe0@gmail.com>

On Tue, Jul 02, 2024 at 12:09:32PM +0200, Javier Carrasco wrote:
> `tps23861_regmap_config` is not modified and can be declared as const to
> move its data to a read-only section.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter

