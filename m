Return-Path: <linux-kernel+bounces-389346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C239B6BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E50928188D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F911BC09A;
	Wed, 30 Oct 2024 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbGCzYOP"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643851A2631;
	Wed, 30 Oct 2024 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730311576; cv=none; b=jBlwoZvsuX/3b97/qf/6OAzUgPL9ST/8ONLX6lMBNr4dAq1XtqYFd/XzfT14/NIPxqZly/vfUfOnLqDmFhexw/a8BIh41B1s0nAD7fHXED/SVHpO2V8tlg9rfirpAln5rHUF1N/7+3G7K87HzjhOHmlaC4iqD541z82AQV8oQQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730311576; c=relaxed/simple;
	bh=LF9noeTji2b7N8JqoErVzO0xyU0Yhb3GiDpnpvg1GoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twJFvm7dX89aT8ayxAQMW24jwdrqvKOszQOf0/ui1DsSFIIvOqxbTaKRZW5uXd6V+G1D2PIGAhLgqj5Ccx8XXe9rYGWjvf0lor7qhHLHnhDx9+alyaQ/bGDCc2puKKdTAHt2aKiH0eREFrdrofM4/9jN/NydsDyVazfKSxYGRPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbGCzYOP; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb49510250so870121fa.0;
        Wed, 30 Oct 2024 11:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730311572; x=1730916372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LF9noeTji2b7N8JqoErVzO0xyU0Yhb3GiDpnpvg1GoY=;
        b=XbGCzYOPxc+o8Z408htylZ0mBgGBvcg0+zf9Dtjp8h7B/y5yUfY/S4z9p2+5oklPig
         wqwKQuufBGCKTvxKO10uKDIlQOuoBp0MXXwe3wo7MM8IUZIWnVrGTWgxBmeasC1Nn2kA
         Wt/wDO+kFcIEDeRVLi0UPS6qi7OQrm/9dffW9nIIN0gijqskW1Y+X8NrUIR6GaukvlVM
         9d7de/L39bLjLyD7q3znds7oTbr2fiTwnLnE9GESqQIHraNeRvjfKGciM8fmCgVYRtPV
         L6ZlxjweCNEo9LY5wBVrOuKH+Ycsao8rh2PfB09tEVQv6AJa9Nh+5B0SAQMTPy53RDMI
         RrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730311572; x=1730916372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LF9noeTji2b7N8JqoErVzO0xyU0Yhb3GiDpnpvg1GoY=;
        b=WcFibNvYx+ZuXQfo8AZ7O3S+AdiCmadECf8ZT+7vEAGFym/pK+rBbTg9pZZLuzmhF2
         fJPerwKlWsq+cagJp+awcF8UR+J6Fk0yJw9/8jcAzW3ZlAh6jOGI+QH++OTiGNg3bycN
         ePdnfAnmFq6dZ/1TGNDEpn2FSXgoavTXM5GJcaqpi5I5A2CDg3F2MFTWv5Zi9vZrqA8T
         WuLzSzLJcvBczs8gvGhcmXnl+EGkwdReUe4IXztbrRl6DsFt8WbRGGgqbobXKy+QDGsB
         dzWZzLw65BW3KC1c7WR1qK+6gKznhnkK3uN2r1IiKaA59s1Xbc8DYkxyw8G5DiLkE7K+
         OLYw==
X-Forwarded-Encrypted: i=1; AJvYcCXsYwIy6q+8PWGTsgdplR2BZmIZRJR6NBEZI1+qCHDLYKh7r0qBRX6hqrmuMoBjEW7/N6NQ02FwQPMD6yY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj1KFF56SsKXe3znvXc/I70vgbOayZDW5NIN2bqZGFz7ql7l4n
	NEeK3SO5aSoLyGzzdKlCLVhcEHUVCA/QeqdZIjHmlSaEGSF8E2UDcVaLzQ==
X-Google-Smtp-Source: AGHT+IHayk77MRC4z7nR2NME3N5ImHKRJYje2Pp2ODSwtTF/mqu+oMiZahVSN8lWYtzUTFV/l8joWQ==
X-Received: by 2002:a2e:743:0:b0:2fb:587d:310 with SMTP id 38308e7fff4ca-2fdecbf82eemr2635661fa.30.1730311572328;
        Wed, 30 Oct 2024 11:06:12 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb629d8c2sm4901115a12.29.2024.10.30.11.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 11:06:11 -0700 (PDT)
Date: Wed, 30 Oct 2024 19:06:09 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Cleanup Spreadtrum/Unisoc ARM64 DT (part 2)
Message-ID: <ZyJ1keHD-neTNZ2J@standask-GA-A55M-S2HP>
References: <cover.1723716331.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723716331.git.stano.jakubek@gmail.com>

Hi all,

not sure which tree this should go through, but could someone pick this up?
It's been sitting for ~2.5 months.

Thanks,
Stanislav

