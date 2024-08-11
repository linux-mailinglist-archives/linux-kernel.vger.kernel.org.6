Return-Path: <linux-kernel+bounces-282331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38DB94E254
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 18:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7987B21346
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 16:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D401537D7;
	Sun, 11 Aug 2024 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMTVaL0A"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E989D18E06;
	Sun, 11 Aug 2024 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723394648; cv=none; b=gzPEuAIfrh1cfz+olmX7BX/Kyl3QrImTOI+y1ZN0PunGBiqJaXpec+zTN1VDNgQ7t0FwKU/u3L0zdlQwHJBgS63eFjaWw1f/F8Qz4eN9X0+D0CIcqARazHvXPB0J03tc4XrgvlJid6s3H4eMlovO99t0pdkWAU9lomVNj10gjwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723394648; c=relaxed/simple;
	bh=Zmsunm964HuzM2ri18gx/TQMJsEOatE4/DOmrifmKWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ai2bnahCj5rMkrlnmDNQstbs+rHaOFv/BRqlQRQtXW8bSTbUopOOZEYTg88hSWhIxEBoTr740jlO0tSKXGUaygbyIUi+L6Mi3O2dA/eo3vT1vXPVOPRBoR65OKm2+wD6BcyhpxFNYLnZPoXUms4gm/+F817pWAjxItPksyoWHno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMTVaL0A; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5d59e491fefso1766197eaf.1;
        Sun, 11 Aug 2024 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723394646; x=1723999446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sJH8hfEK81Q8nQYIEInnXVBydwUeu1gKVM21zLkZMA=;
        b=BMTVaL0AsJX8r3mvbeD1kApA1Z+l6oT/QViBs3JkoZPxulGOuadV5yd14hgPbln3C3
         nz3g5OwhW0wi4O9gitmMtIo0wF+SOFSppuzX3Ohun1f51kmqb5lV3NBXUo2V7ko6mL5r
         8/DSphXcXlGNVX7GyvO6F5ZmCcEPRIg+w/fhH4OPV270voobHQdOOhCKw5PRc7ZKI1yf
         hQ1f/9r2Bbkk3a8wcCsTYJlCn6UdMLRxF/IAMyhxRzR7imRiDpjjFF26aFyH65J135HA
         SQd56ple1EOlC8JqFKMY5Dxay29e6ff7OgO9Acz17Hd8PfgpWiZrSsd6CaPeKbhqFXKM
         ri/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723394646; x=1723999446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5sJH8hfEK81Q8nQYIEInnXVBydwUeu1gKVM21zLkZMA=;
        b=mkd4ilVgUAWsxL1u0hKsOX0nzU9xuQzGCw/Ruig6hYkygSOcQL/hww05ynG0COROd1
         kC9No+6e3+X61YdVcQx3wv9Y3JsIAw/L3I17wvMT3wjxW3xNrJe6MFDa85k5ot8uwnm7
         ymGYlTxfHZQqBWGWA9HoscZyfBd6uvl1rnlz8vgJHdHiYba+GPGZH7r2eIIr7+VX6dBy
         UURUO4317xfU7xU/wo/W+vMdKafCV4XTeEIbygPLJVf2pFq/sH6qDC4V4oRy2lLR83NY
         H9tbPSie8qGBTMFKh2wiBxiwQdeRJpIgYSaBgFpZXiC+WPUxqXJQOB+u6u8rzvrlFvYS
         Bbew==
X-Forwarded-Encrypted: i=1; AJvYcCVOFe/yV6nueGKWF42WsUXPq08+b+Ep3rKd2nvMx4n69JlupG7fO0ecta+NYQB+Llo+z7QZQWvrgNWhJUjI8g2TXkCP0JXqCY0Sm3AW
X-Gm-Message-State: AOJu0YwvRkFx3JzvbIPBHcxo02EElgHkHSMp5kgxk6+ZMUDVyxqA5iIz
	yM8XqJIkohDsDyvPUM2OXA54mgPhzfIBwWfhZ+w1AQpyuQbtQOxr
X-Google-Smtp-Source: AGHT+IFTVTapixqAHDc9XcjCZ55b6J52aJUgIFUIx78Ch4jHuaGuI9MW8g4HeEjhD2b1077bH4v+OA==
X-Received: by 2002:a05:6820:229f:b0:5d8:10cb:c336 with SMTP id 006d021491bc7-5d867d39531mr7092151eaf.1.1723394645709;
        Sun, 11 Aug 2024 09:44:05 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:dff5:4180:2562:4c1e? ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5da3e53e167sm924909eaf.5.2024.08.11.09.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 09:44:05 -0700 (PDT)
Message-ID: <e555c73b-e060-40d6-aee7-e7e40ceae4ee@gmail.com>
Date: Sun, 11 Aug 2024 11:44:04 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/sp_Sp: Add translation to spanish of the
 documentation related to EEVDF
To: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20240810111513.20049-1-sergio.collado@gmail.com>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20240810111513.20049-1-sergio.collado@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 8/10/24 06:15, Sergio González Collado wrote:
> Translate Documentation/scheduler/sched-eevdf.rst to spanish.


s/spanish/Spanish


>
> Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
> ---
>  v1 -> v2: correct the commit message.
> ---
>  .../translations/sp_SP/scheduler/index.rst    |  1 +
>  .../sp_SP/scheduler/sched-design-CFS.rst      |  8 +--
>  .../sp_SP/scheduler/sched-eevdf.rst           | 58 +++++++++++++++++++
>  3 files changed, 63 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/translations/sp_SP/scheduler/sched-eevdf.rst
>
> diff --git a/Documentation/translations/sp_SP/scheduler/index.rst b/Documentation/translations/sp_SP/scheduler/index.rst
> index 768488d6f001..32f9fd7517b2 100644
> --- a/Documentation/translations/sp_SP/scheduler/index.rst
> +++ b/Documentation/translations/sp_SP/scheduler/index.rst
> @@ -6,3 +6,4 @@
>      :maxdepth: 1
>  
>      sched-design-CFS
> +    sched-eevdf
> diff --git a/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst b/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
> index 90a153cad4e8..8b8eb581c7be 100644
> --- a/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
> +++ b/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
> @@ -14,10 +14,10 @@ Gestor de tareas CFS
>  
>  CFS viene de las siglas en inglés de "Gestor de tareas totalmente justo"
>  ("Completely Fair Scheduler"), y es el nuevo gestor de tareas de escritorio
> -implementado por Ingo Molnar e integrado en Linux 2.6.23. Es el sustituto de
> -el previo gestor de tareas SCHED_OTHER.
> -
> -Nota: El planificador EEVDF fue incorporado más recientemente al kernel.
> +implementado por Ingo Molnar e integrado en Linux 2.6.23. Es el sustituto
> +del previo gestor de tareas SCHED_OTHER. Hoy en día se está abriendo camino
> +para el gestor de tareas EEVDF cuya documentación se puede ver en


s/EEVDF/EEVDF,


> +Documentation/scheduler/sched-eevdf.rst
>  
>  El 80% del diseño de CFS puede ser resumido en una única frase: CFS
>  básicamente modela una "CPU ideal, precisa y multi-tarea" sobre hardware
> diff --git a/Documentation/translations/sp_SP/scheduler/sched-eevdf.rst b/Documentation/translations/sp_SP/scheduler/sched-eevdf.rst
> new file mode 100644
> index 000000000000..54f68473f31a
> --- /dev/null
> +++ b/Documentation/translations/sp_SP/scheduler/sched-eevdf.rst
> @@ -0,0 +1,58 @@
> +
> +.. include:: ../disclaimer-sp.rst
> +
> +:Original: :ref:`Documentation/scheduler/sched-eevdf.rst <sched_eevdf>`
> +:Translator: Sergio González Collado <sergio.collado@gmail.com>
> +
> +======================
> +Gestor de tareas EEVDF
> +======================
> +
> +El gestor de tareas EEVDF,del inglés: "Earliest Eligible Virtual Deadline


s/EEVDF,del/EEVDF, del

(With a space)


> +First", fue presentado por primera vez en una publicación científica en
> +1995 [1]. El kernel de Linux comenzó a transicionar hacia EEVPF en la
> +versión 6.6 (y como una nueva opción en 2024), alejándose del gestor
> +de tareas CFS, en favor de una versión de EEVDF propuesta por Peter
> +Zijlstra en 2023 [2-4]. Más información relativa a CFS puede encontrarse
> +en Documentation/scheduler/sched-design-CFS.rst.
> +
> +De forma parecida a CFS, EEVDF intenta distribuir el tiempo de ejecución
> +de la CPU de forma equitativa entre todas las tareas que tengan la misma
> +prioridad y puedan ser ejecutables. Para eso, asigna un tiempo de
> +ejecución virtual a cada tarea, creando un "retraso" que puede ser usado
> +para determinar si una tarea ha recibido su cantidad justa de tiempo
> +de ejecución en la CPU. De esta manera, una tarea con un "retraso"
> +positivo, es porque se le debe tiempo de ejecución, mientras que una
> +con "retraso" negativo implica que la tarea ha excedido su cuota de
> +tiempo. EEVDF elige las tareas con un "retraso" mayor igual a cero y
> +calcula un tiempo límite de ejecución virtual (VD, del inglés: virtual
> +deadline) para cada una, eligiendo la tarea con la VD más próxima para
> +ser ejecutada a continuación. Es importante darse cuenta que esto permite
> +que la tareas que sean sensibles a la latencia que tengan porciones de
> +tiempos de ejecución de CPU más cortos ser priorizadas, lo cual ayuda con
> +su menor tiempo de respuesta.
> +
> +Ahora mismo se está discutiendo cómo gestionar esos "retrasos", especialmente
> +en tareas que estén en un estado durmiente; pero en el momento en el que
> +se escribe este texto EEVDF usa un mecanismo de "decaimiento" basado en el
> +tiempo virtual de ejecución (VRT, del inglés: virtual run time). Esto previene
> +a las tareas de abusar del sistema simplemente durmiendo brevemente para
> +reajustar su retraso negativo: cuando una tarea duerme, esta permanece en
> +la cola de ejecución pero marcada para "desencolado diferido", permitiendo
> +a su retraso decaer a lo largo de VRT. Por tanto, las tareas que duerman
> +por más tiempo eventualmente eliminarán su retraso. Finalmente, las tareas
> +pueden adelantarse a otras si su VD es más próximo el tiempo, y las


s/el tiempo/en el tiempo


> +tareas podrán pedir porciones de tiempo específicas con la nueva llamada
> +del sistema sched_setattr(), todo esto facilitara el trabajo en las aplicaciones


s/en las/de las


> +que sean sensibles a las latencias.
> +
> +REFERENCIAS
> +===========
> +
> +[1] https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=805acf7726282721504c8f00575d91ebfd750564
> +
> +[2] https://lore.kernel.org/lkml/a79014e6-ea83-b316-1e12-2ae056bda6fa@linux.vnet.ibm.com/
> +
> +[3] https://lwn.net/Articles/969062/
> +
> +[4] https://lwn.net/Articles/925371/
> -- 2.39.2


Nice! With these changes,

Reviewed-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>


