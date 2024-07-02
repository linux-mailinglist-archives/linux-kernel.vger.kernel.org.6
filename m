Return-Path: <linux-kernel+bounces-238237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2195892474D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08EF2877BA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EF61CCCBA;
	Tue,  2 Jul 2024 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Slmic2e0"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EE01DFFC;
	Tue,  2 Jul 2024 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945077; cv=none; b=of9qp6BiIAjeqRP+um2AdfNVK2Fhw6omUktH/OzqkFERASh9+spkUALZgDRDHx3jN+fSoKUwLi7HbyvkA+fNiipDObwiMCE6MGa7R3SsziBEToRWJvWFeV78sIyCEBaxuNfs7am68QjhoGWUTgOzIsgAVd482ti00sbKKCyeuDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945077; c=relaxed/simple;
	bh=ajV8bcMNlgAkZcumdPfbsMKyXvtW4/DzErFFKD2t2Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCYoRTPMsCi445zrBNnJXNtbpao1FWnKTdXsdo6pNXrUo4GPKTPE6/Wn2tKPUpznK0v/pA3C8G5U7MUgsXSFIqwWbnCg5KE9aUIEyRYnqe1HZVgqQ7hyZt2nfqjLDtLVYu9v4CmWOjE+iOiNuTGmLPCqjn1Tuf6X50vZd+8lf4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Slmic2e0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f4a5344ec7so33233725ad.1;
        Tue, 02 Jul 2024 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719945075; x=1720549875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJNHmg8mupLRV/Ae7ec2+od/VcxnoOH/c/zoL21B8P4=;
        b=Slmic2e01VrUjTd1pQdMTuVZw9P48EchDQz2xSmbLhcLnnAW2OMnzNBxIDX5cwv4YB
         KGnCbfSje/JEsSwvczuBviKGHoIc+C6fUV5FKLgl33qVMukW5WvCNIfq+Ky09V8+pVlN
         1eI+Mzw89Jn9fZtPm9o8UzIsevQBP1jRvQIzOZjPXYfOlfR+oZyjmcc1CDHtHJYO3Dpj
         mUM03E7PJahuh9G5W5wIp5CfP8mF62IWOKguYzO64noiuFSa8VM19gZwWzmuIZMGmzD5
         biIIIq9XZHC7rw9elt54tFkbPxMzIDDCxIA5SPFM/ZAocvUENaHx8VlOIHkeLlj52ROx
         7q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719945075; x=1720549875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJNHmg8mupLRV/Ae7ec2+od/VcxnoOH/c/zoL21B8P4=;
        b=OfvtJ7t96g3rVkSY8dl7c8t1kHD/Q9BbtZjm0IB9dPnNeWwcLjAQP2G17w0kUoNTR8
         iVChDIUOVWB/3ZUbX2vj8QHuiy/0hwt12hkN37QNxeReH7xMhTt4WmtPFEhNuMD8l1wT
         BqyAYMwJQd63U1Wcg4Kt/FIisuf7ZHS7gW37ij/XIhcspYFNlRo3yOj/pnPMU4wUXJKh
         gp+Mi9fgoQCyGI64Oz//lm4Kp00VfhlWXS3Adw3rBYBAIppHeb9xOrSWqBrU9wSjWiOh
         rLKdqN4EuOG08f92+8D+NkMvJ1YJBzFxbyif/k15wBTFV/MT7Uq2u5J0Q/prCJVDI+tG
         GvBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR0xF5wRK6xiFOSqYzVtqzBzQAZAQ3UXhEDc5iEHlGVny8cJ5wSzPdeTUNzCr/XJk9j8fpiLK4ZnyOB4XAA4LRO7wgbiR0NEOJsFvpx+Iwn6LBE7zqAXn9z9Ck3YhALbhTqQAoKaXgO/M=
X-Gm-Message-State: AOJu0Yz/8dGvebSXcjI9BVjNEgrcGb2jn+yF6OhqvpKNPcX/8OscPI+H
	ThSyQDuCsvDxE2D3TBCtt8RIRcEYJMc7fx3MJ2O50PHQUAsxDcf1
X-Google-Smtp-Source: AGHT+IEJ3VdexfLCVmXK7PehZluiVzy2JLN6EBRTIqqA61bulxAF/3nqEgYb+7WPjgHUutul72vqMA==
X-Received: by 2002:a17:903:41cc:b0:1f7:1b42:42f3 with SMTP id d9443c01a7336-1fac7e80acfmr192082895ad.18.1719945074995;
        Tue, 02 Jul 2024 11:31:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15788b9sm87643945ad.211.2024.07.02.11.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 11:31:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 2 Jul 2024 11:31:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	Eric Tremblay <etremblay@distech-controls.com>,
	Robert Marko <robert.marko@sartura.hr>,
	Luka Perkov <luka.perkov@sartura.hr>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: (tmp513) Constify struct regmap_config
Message-ID: <19448740-e12b-4da9-a2e0-f895905834fe@roeck-us.net>
References: <20240702-hwmon-const-regmap-v1-0-63f6d4765fe0@gmail.com>
 <20240702-hwmon-const-regmap-v1-2-63f6d4765fe0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702-hwmon-const-regmap-v1-2-63f6d4765fe0@gmail.com>

On Tue, Jul 02, 2024 at 12:09:31PM +0200, Javier Carrasco wrote:
> `tmp51x_regmap_config` is not modified and can be declared as const to
> move its data to a read-only section.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter

