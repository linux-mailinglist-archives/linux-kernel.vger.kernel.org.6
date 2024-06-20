Return-Path: <linux-kernel+bounces-223470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D8391138C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65DC284AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C7558AC3;
	Thu, 20 Jun 2024 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bC7Jnas5"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1AE5A4E9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916134; cv=none; b=Y1T7APQFj9sRlBvEa+mmn7xIN8qQXnXwhW0Vg/7jj6PI/JgUZtH4doTR94G0q9jCSLm4GRz5qHBIujnv468NrnQ+7l9NTmYAXdHHs6o5DxcNCwBVBBeWWESuASZ6krr19PVPpQ43KgC6yF6fHTS9cCJ8jUljnaGJjJLGEiw4+ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916134; c=relaxed/simple;
	bh=rZTYzdCvbBVM72bJ3BfGpq2tUtYH+usxtmwVz5R+FIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A05iBpZ3hIbbcaZtKctHd/nx5bXZ24QzSr7Xao32UU/DhSML3o/LCa49BV68+dWlnLut0i6QPwoV/+tyZ4e53vrnr9HeZQqVhdMK2FOvsl/beQf/klVmA0HJgdD4VxqZrMVVrVIcUn/U/9ye4pvbvVMONan1UgGw1Hb0nLE2cuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bC7Jnas5; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec4a35baa7so6024721fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718916131; x=1719520931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6K5OP7x7yq5Q0DYuXqAaTFJPJUMdV4vBwX3KqhQElbE=;
        b=bC7Jnas5Qo+CvGeVWWd+dNA/ZCzrR7DK1VbveLiWnzIx2cHaUXdGSaYTsUIFUzqJiR
         9E753WZ3E0WxaiCIEQWNwrDv7uIKqPp4mZo+xTnTjX58j8PuszEwzZEMs6uVsFuNoLUt
         FuPMlFt54f58RJ5x0nd/i+1Le5suy8PwgO1j2qzPnuLioWGVpKFa43iIp5zG5/a3AJoz
         Xx7USY2knvgAWsPw3FmBpBtzsjuY7ZM7PVgC9USw4s3ZEN909mChwcjgQ3wR8C0iQsEf
         zmVbTyCnrG1B8HMOuU1PjnuvOEdlZ/2wFu4mBdIr8RS/C2HfEZSIrGXTovpK9mBgaXan
         LPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718916131; x=1719520931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6K5OP7x7yq5Q0DYuXqAaTFJPJUMdV4vBwX3KqhQElbE=;
        b=CIWN8a4qrzy0vFar8ySe5j3eZsMLOjD6oHixpiCIxR77wdBLJbNgizFSnmZ5WjX3He
         9KSV7Mbo/nIS8U6GoAyuZGzIwr60ZE6N1LtxEY6VBs+LQzxORKN3haoxFuhx+bGFQ4Az
         esb4J3M+82yFQNFcQCoZnYHBidVVPt9F2zZYV4uqqDC+mLbr5VNQE1kUmJheRYmyPBiQ
         eZGi1sOpuQe2Eozkv1pxzhc418cPE2G5L5heyKy7jE7PwpH9pl9WvA6OsmF8dDXfYb/b
         HvaWQKX9t7xvpqi8AayedkYXWOvRp7v1u8SbnzYbjvlYJeYezLTF6b7o32nvmXwNXu9/
         dQAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU575LYz9ZIv2UiRIL90BX03qFJOelY6zauC9D8uSvyM9R1l+vhBY8S5G8e21k9QCq9VW50sEV32QGeKhCU+W9bOBeiTfwlUrmX72uk
X-Gm-Message-State: AOJu0YyjP1jiy+nz+XLkEivA6XjZZ1XpyO7xi5ScxrwCghzJy2CwIWiP
	Ggq9lUDQj3PNUl3WD/ch/c3mrNEIRCPJkwGHpIvYn3vT5k8IjC9gqlzQwp4j8RM=
X-Google-Smtp-Source: AGHT+IHa++EtjUUyDrE9RDcUSFkXO7DWuSSI9krY6EtnVLoSOEWveJuA9bY90htEUz1EKaY81P3z4w==
X-Received: by 2002:a2e:998c:0:b0:2eb:d9d9:6ea5 with SMTP id 38308e7fff4ca-2ec3cff4a6dmr17759271fa.26.1718916131531;
        Thu, 20 Jun 2024 13:42:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d600c1bsm167431fa.8.2024.06.20.13.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 13:42:11 -0700 (PDT)
Date: Thu, 20 Jun 2024 23:42:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca@lucaweiss.eu>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: msm8976: Use mboxes in smsm node
Message-ID: <5zxq7j2a2juahsy3svlog6zvjkycejmlj7zqesgtllxiw4iw5s@2zwrllvtnidi>
References: <20240619-smsm-mbox-dts-v1-0-268ab7eef779@lucaweiss.eu>
 <20240619-smsm-mbox-dts-v1-5-268ab7eef779@lucaweiss.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619-smsm-mbox-dts-v1-5-268ab7eef779@lucaweiss.eu>

On Wed, Jun 19, 2024 at 06:42:31PM GMT, Luca Weiss wrote:
> With the smsm bindings and driver finally supporting mboxes, switch to
> that and stop using apcs as syscon.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---
>  arch/arm64/boot/dts/qcom/msm8976.dtsi | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

