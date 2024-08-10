Return-Path: <linux-kernel+bounces-281868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E952794DC4B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 12:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD1BCB21A54
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 10:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EFA156C4B;
	Sat, 10 Aug 2024 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB0i6xXU"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508463D0A9;
	Sat, 10 Aug 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723285834; cv=none; b=cnEVvVTtCoPFX0QUZmb/6x93otYRV0kcLM48Dmab8DPZS9VXRAiQPFuaGv1NwZjtlrsSHHJpC4tW0JlpPVWgpTnudDnnx6PjU2P1hEbhIMubdYRrgj2Bce4GoejeC/SQvICpJ3TdrKUREi06BRH45O8QOCV9c/Xh53i6J4y7/8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723285834; c=relaxed/simple;
	bh=k7pVHCsAGKPkafm34jifW+omKK3NdYdltMmv/r5WzFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8uml+so4suAT87P8GBBoAmL7spMzzfhd3oLdn3Zp4uqNbCzjl2aIWGfkHXfRc7ySx8rzrZhJV9CZxFL5VHjEO5IyzidRpG8gvh+53hVfw+b2ywpaMs8w0VhakZ3qVThusntFU9oNXPDswtmVdXDD8twlcZDePjPfMT8PEJ+WaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dB0i6xXU; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cd48ad7f0dso2313940a91.0;
        Sat, 10 Aug 2024 03:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723285831; x=1723890631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNo66/lu2Sn1UnrGFD/+kw8GMUASDsiCEkqSVq3iuDk=;
        b=dB0i6xXU2yFkvZyI4VccznTjil2Zya1UsaDHG5cudeffVCUtMHr56SZP6ZrFDaCrom
         klAUcf03lFYRSFpqzJaUvOFhZm6EmUx6kQdMoHOI2+Syy0qEhphZJo4HvuUn/OVtF0Oe
         /pKYqALfkgKk8TYXu+Uaqv6XwAB1plHWIftK+wRhgQqb/LK4hi5/8s5PJIvE2HnEXSib
         K7isi1i4Fjg6Ol5XB6VCPofOE8J+F8q3QjjULlPGMYosfiMcu7m5homLNgatIM2zMLZ1
         KwEmPFyETa33AduFlFiJ61Guq6oM4GK4cvRRu42w3gpiTro34xYjAJPKBfRrfZpdmZTn
         Ltdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723285831; x=1723890631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNo66/lu2Sn1UnrGFD/+kw8GMUASDsiCEkqSVq3iuDk=;
        b=qAPp0crzp9sjxiz1V8+jc4V6pzWoHu4NtWBZLA8XIRg/ELga69Flc7nKA0bhpIeJDC
         8XotiD1NV1x0CwY3lGSbx2Bft+eFx77fpwBU97iDNSnerpds11Xys5ZlegAeB99qaCNj
         zx5jG5rEZbFQcPWdtabrQxfbJSiR3NsN5R1IYLPPvVgJcf/C2zWCfCjoz60CdW4F9KO3
         zSwTC8KO2nhIdmh8W3/1Qgz0pHLYxCcxXrVc5bE1QPR7nthZG3i/mzbk4ycq+XVRLDU4
         RHd9mNoq7y+2znYa90g0Hfea/EVRGZKAhnwoN/SYMeqDU+naBqelH4iJ80L4awbxKtI7
         rzjw==
X-Forwarded-Encrypted: i=1; AJvYcCV3stX1odJ0sEw+78kCfaqSa6aRdgl+A7ZqdJwcUEt102LevpD6U991gsNnAfytRPH7KGsFhbmqpLZ7qYVQYgJ87vS9RYnsVAiRvNll
X-Gm-Message-State: AOJu0YzSAdxrcJAaxWsE5V9jSPmQtksOQY6GAysbqytJ1rpEbsNnka2h
	MS00//3CA0Eoaxa6/wVoob85SZOpLmD9ExaANtmCkdTmtb/tyJz9rU4S/kHl8v4OXuVfesZ4F56
	q40GkMf+JVfhBb7/v8Sc7+DkOxSg=
X-Google-Smtp-Source: AGHT+IFP4ghJMa6rgBAIH/DQAFqgvK8qb+jU9ggSWZnZSSJT3sNLsIWLX1NyYewQy/iss3eTt8sDNsA/dTqfGGZsSqc=
X-Received: by 2002:a17:90b:1c01:b0:2c9:8891:e12a with SMTP id
 98e67ed59e1d1-2d1e7fe1ec8mr4678236a91.23.1723285831317; Sat, 10 Aug 2024
 03:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240810101522.15299-1-sergio.collado@gmail.com>
In-Reply-To: <20240810101522.15299-1-sergio.collado@gmail.com>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Sat, 10 Aug 2024 12:29:53 +0200
Message-ID: <CAA76j90fYOPBN8Ei1Upd61R_zk_3zpo0WGtmuLysa2QRRRpNiQ@mail.gmail.com>
Subject: Re: [PATCH v3] docs/sp_SP: Add translation for scheduler/sched-bwc.rst
To: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, 
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Excuse me, I sent a bunch of patches, and that was not what I
intended, surely I'm not handling git-email properly. Please just
consider the last one.

On Sat, 10 Aug 2024 at 12:15, Sergio Gonz=C3=A1lez Collado
<sergio.collado@gmail.com> wrote:
>
> Translate Documentation/scheduler/sched-bwc.rst into Spanish.
>
> Signed-off-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
> ---
> v1 -> v2 typos corrected
> ---
> v2 -> v3 typos corrected
> ---
>  .../translations/sp_SP/scheduler/index.rst    |   1 +
>  .../sp_SP/scheduler/sched-bwc.rst             | 287 ++++++++++++++++++
>  2 files changed, 288 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/scheduler/sched-bwc.=
rst
>
> diff --git a/Documentation/translations/sp_SP/scheduler/index.rst b/Docum=
entation/translations/sp_SP/scheduler/index.rst
> index 768488d6f001..3aef47ca87e0 100644
> --- a/Documentation/translations/sp_SP/scheduler/index.rst
> +++ b/Documentation/translations/sp_SP/scheduler/index.rst
> @@ -6,3 +6,4 @@
>      :maxdepth: 1
>
>      sched-design-CFS
> +    sched-bwc
> diff --git a/Documentation/translations/sp_SP/scheduler/sched-bwc.rst b/D=
ocumentation/translations/sp_SP/scheduler/sched-bwc.rst
> new file mode 100644
> index 000000000000..52b372f8a502
> --- /dev/null
> +++ b/Documentation/translations/sp_SP/scheduler/sched-bwc.rst
> @@ -0,0 +1,287 @@
> +.. include:: ../disclaimer-sp.rst
> +
> +:Original: :ref:`Documentation/scheduler/sched-design-CFS.rst <sched_des=
ign_CFS>`
> +:Translator: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
> +
> +.. _sp_sched_bwc:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +CFS con control de ancho de banda
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. note::
> +   Este documento =C3=BAnicamente trata el control de ancho de banda de =
CPUs
> +   para SCHED_NORMAL. El caso de SCHED_RT se trata en Documentation/sche=
duler/sched-rt-group.rst
> +
> +El control de ancho de banda es una extensi=C3=B3n CONFIG_FAIR_GROUP_SCH=
ED que
> +permite especificar el m=C3=A1ximo uso disponible de CPU para un grupo o=
 una jerarqu=C3=ADa.
> +
> +El ancho de banda permitido para un grupo de tareas se especifica usando=
 una
> +cuota y un periodo. Dentro de un "periodo" (microsegundos), a un grupo
> +de tareas se le asigna hasta su "cuota" de tiempo de uso de CPU en
> +microsegundos. Esa cuota es asignada para cada CPU en colas de ejecuci=
=C3=B3n
> +en porciones de tiempo de ejecuci=C3=B3n en la CPU seg=C3=BAn los hilos =
de ejecuci=C3=B3n
> +del grupo de tareas van siendo candidatos a ejecutarse. Una vez toda la =
cuota
> +ha sido asignada cualquier petici=C3=B3n adicional de cuota resultar=C3=
=A1 en esos hilos
> +de ejecuci=C3=B3n siendo limitados/estrangulados. Los hilos de ejecuci=
=C3=B3n limitados
> +no ser=C3=A1n capaces de ejecutarse de nuevo hasta el siguiente periodo =
cuando
> +la cuota sea restablecida.
> +
> +La cuota sin asignar de un grupo es monitorizada globalmente, siendo
> +restablecidas cfs_quota unidades al final de cada periodo. Seg=C3=BAn lo=
s
> +hilos de ejecuci=C3=B3n van consumiendo este ancho de banda, este se
> +transfiere a los "silos" de las cpu-locales en base a la demanda. La
> +cantidad transferida en cada una de esas actualizaciones es ajustable y
> +es descrito como un "slice".
> +
> +Caracter=C3=ADstica de r=C3=A1faga
> +--------------------------
> +
> +Esta caracter=C3=ADstica toma prestado tiempo ahora, que en un futuro te=
ndr=C3=A1 que
> +devolver, con el coste de una mayor interferencia hacia los otros usuari=
os
> +del sistema. Todo acotado perfectamente.
> +
> +El tradicional control de ancho de banda (UP-EDF) es algo como:
> +
> +  (U =3D \Sum u_i) <=3D 1
> +
> +Esto garantiza dos cosas: que cada tiempo l=C3=ADmite de ejecuci=C3=B3n =
es cumplido
> +y que el sistema es estable. De todas formas, si U fuese > 1, entonces
> +por cada segundo de tiempo de reloj de una tarea, tendr=C3=ADamos que
> +ejecutar m=C3=A1s de un segundo, y obviamente no se cumplir=C3=ADa con e=
l tiempo
> +l=C3=ADmite de ejecuci=C3=B3n de la tarea, pero en el siguiente periodo =
de ejecuci=C3=B3n
> +el tiempo l=C3=ADmite de la tarea estar=C3=ADa todav=C3=ADa m=C3=A1s lej=
os, y nunca se tendr=C3=ADa
> +tiempo de alcanzar la ejecuci=C3=B3n, cayendo as=C3=AD en un fallo no ac=
otado.
> +
> +La caracter=C3=ADstica de r=C3=A1faga implica que el trabajo de una tare=
a no siempre
> +consuma totalmente la cuota; esto permite que se pueda describir u_i
> +como una distribuci=C3=B3n estad=C3=ADstica.
> +
> +Por ejemplo, se tiene u_i =3D {x,e}_i, donde x es el p(95) y x+e p(100)
> +(el tradicional WCET (WCET:Worst Case Execution Time: son las siglas
> +en ingl=C3=A9s para "peor tiempo de ejecuci=C3=B3n")). Esto efectivament=
e permite
> +a u ser m=C3=A1s peque=C3=B1o, aumentando la eficiencia (podemos ejecuta=
r m=C3=A1s
> +tareas en el sistema), pero al coste de perder el instante l=C3=ADmite d=
e
> +finalizaci=C3=B3n deseado de la tarea, cuando coincidan las peores
> +probabilidades. De todas formas, si se mantiene la estabilidad, ya que
> +cada sobre-ejecuci=C3=B3n se empareja con una infra-ejecuci=C3=B3n en ta=
nto x est=C3=A9
> +por encima de la media.
> +
> +Es decir, sup=C3=B3ngase que se tienen 2 tareas, ambas espec=C3=ADficame=
nte
> +con p(95), entonces tenemos p(95)*p(95) =3D 90.25% de probabilidad de
> +que ambas tareas se ejecuten dentro de su cuota asignada y todo
> +salga bien. Al mismo tiempo se tiene que p(5)*p(5) =3D 0.25% de
> +probabilidad que ambas tareas excedan su cuota de ejecuci=C3=B3n (fallo
> +garantizado de su tiempo final de ejecuci=C3=B3n). En alg=C3=BAn punto p=
or
> +en medio, hay un umbral donde una tarea excede su tiempo l=C3=ADmite de
> +ejecuci=C3=B3n y la otra no, de forma que se compensan; esto depende de =
la
> +funci=C3=B3n de probabilidad acumulada espec=C3=ADfica de la tarea.
> +
> +Al mismo tiempo, se puede decir que el peor caso de sobrepasar el
> +tiempo l=C3=ADmite de ejecuci=C3=B3n ser=C3=A1 \Sum e_i; esto es una ret=
raso acotado
> +(asumiendo que x+e es de hecho el WCET).
> +
> +La interferencia cuando se usa una r=C3=A1faga se eval=C3=BAa por las po=
sibilidades
> +de fallar en el cumplimiento del tiempo l=C3=ADmite y el promedio de WCE=
T.
> +Los resultados de los tests han mostrado que cuando hay muchos cgroups o
> +una CPU est=C3=A1 infrautilizada, la interferencia es m=C3=A1s limitada.=
 M=C3=A1s detalles
> +se aportan en: https://lore.kernel.org/lkml/5371BD36-55AE-4F71-B9D7-B86D=
C32E3D2B@linux.alibaba.com/
> +
> +Gesti=C3=B3n:
> +--------
> +
> +Cuota, periodo y r=C3=A1faga se se gestionan dentro del subsistema de cp=
u por medio
> +de cgroupfs.
> +
> +.. note::
> +   Los archivos cgroupfs descritos en esta secci=C3=B3n solo se aplican =
al
> +   cgroup v1. Para cgroup v2, ver :ref:`Documentation/admin-guide/cgroup=
-v2.rst <cgroup-v2-cpu>`.
> +
> +- cpu.cfs_quota_us: tiempo de ejecuci=C3=B3n que se refresca cada period=
o (en microsegundos)
> +- cpu.cfs_period_us: la duraci=C3=B3n del periodo (en microsegundos)
> +- cpu.stat: exporta las estad=C3=ADsticas de limitaci=C3=B3n [explicado =
a continuaci=C3=B3n]
> +- cpu.cfs_burst_us: el m=C3=A1ximo tiempo de ejecuci=C3=B3n acumulado (e=
n microsegundos)
> +
> +Los valores por defecto son::
> +
> +       cpu.cfs_period_us=3D100ms
> +       cpu.cfs_quota_us=3D-1
> +       cpu.cfs_burst_us=3D0
> +
> +Un valor de -1 para cpu.cfs_quota_us indica que el grupo no tiene ningun=
a
> +restricci=C3=B3n de ancho de banda aplicado, ese grupo se describe como =
un grupo
> +con ancho de banda sin restringir. Esto representa el comportamiento
> +tradicional para CFS.
> +
> +Asignar cualquier valor (v=C3=A1lido) y positivo no menor que cpu.cfs_bu=
rst_us
> +definir=C3=A1 el l=C3=ADmite del ancho de banda. La cuota m=C3=ADnima pe=
rmitida para
> +la cuota o periodo es 1ms. Hay tambi=C3=A9n un l=C3=ADmite superior en l=
a duraci=C3=B3n del
> +periodo de 1s. Existen restricciones adicionales cuando los l=C3=ADmites=
 de
> +ancho de banda se usan de manera jer=C3=A1rquica, estos se explican en m=
ayor
> +detalle m=C3=A1s adelante.
> +
> +Asignar cualquier valor negativo a cpu.cfs_quota_us eliminar=C3=A1 el l=
=C3=ADmite de
> +ancho de banda y devolver=C3=A1 de nuevo al grupo a un estado sin restri=
cciones.
> +
> +Un valor de 0 para cpu.cfs_burst_us indica que el grupo no puede acumula=
r
> +ning=C3=BAn ancho de banda sin usar. Esto hace que el control del compor=
tamiento
> +tradicional del ancho de banda para CFS no cambie. Definir cualquier val=
or
> +(v=C3=A1lido) positivo no mayor que cpu.cfs_quota_us en cpu.cgs_burst_us=
 definir=C3=A1
> +el l=C3=ADmite con el ancho de banda acumulado no usado.
> +
> +Cualquier actualizaci=C3=B3n a las especificaciones del ancho de banda u=
sado
> +por un grupo resultar=C3=A1 en que se deje de limitar si est=C3=A1 en un=
 estado
> +restringido.
> +
> +Ajustes globales del sistema
> +----------------------------
> +
> +Por eficiencia el tiempo de ejecuci=C3=B3n es transferido en lotes desde=
 una reserva
> +global y el "silo" de una CPU local. Esto reduce en gran medida la presi=
=C3=B3n
> +por la contabilidad en grandes sistemas. La cantidad transferida cada ve=
z
> +que se requiere una actualizaci=C3=B3n se describe como "slice".
> +
> +Esto es ajustable v=C3=ADa procfs::
> +
> +       /proc/sys/kernel/sched_cfs_bandwidth_slice_us (valor por defecto=
=3D5ms)
> +
> +Valores de "slice" m=C3=A1s grandes reducir=C3=A1n el costo de transfere=
ncia, mientras
> +que valores m=C3=A1s peque=C3=B1os permitir=C3=A1n un control m=C3=A1s f=
ino del consumo.
> +
> +Estad=C3=ADsticas
> +------------
> +
> +Las estad=C3=ADsticas del ancho de banda de un grupo se exponen en 5 cam=
pos en cpu.stat.
> +
> +cpu.stat:
> +
> +- nr_periods: N=C3=BAmero de intervalos aplicados que han pasado.
> +- nr_throttled: N=C3=BAmero de veces que el grupo ha sido restringido/li=
mitado.
> +- throttled_time: La duraci=C3=B3n de tiempo total (en nanosegundos) en =
las
> +  que las entidades del grupo han sido limitadas.
> +- nr_bursts: N=C3=BAmero de periodos en que ha ocurrido una r=C3=A1faga.
> +- burst_time: Tiempo acumulado (en nanosegundos) en la que una CPU ha
> +  usado m=C3=A1s de su cuota en los respectivos periodos.
> +
> +Este interfaz es de solo lectura.
> +
> +Consideraciones jer=C3=A1rquicas
> +---------------------------
> +
> +La interfaz refuerza que el ancho de banda de una entidad individual
> +sea siempre factible, esto es: max(c_i) <=3D C. De todas maneras,
> +la sobre-suscripci=C3=B3n en el caso agregado est=C3=A1 expl=C3=ADcitame=
nte permitida
> +para hacer posible sem=C3=A1nticas de conservaci=C3=B3n de trabajo dentr=
o de una
> +jerarquia.
> +
> +  e.g. \Sum (c_i) puede superar C
> +
> +[ Donde C es el ancho de banda de el padre, y c_i el de su hijo ]
> +
> +Hay dos formas en las que un grupo puede ser limitado:
> +
> +        a. este consume totalmente su propia cuota en un periodo.
> +        b. la cuota del padre es consumida totalmente en su periodo.
> +
> +En el caso b) anterior, incluso si el hijo pudiera tener tiempo de
> +ejecuci=C3=B3n restante, este no le ser=C3=A1 permitido hasta que el tie=
mpo de
> +ejecuci=C3=B3n del padre sea actualizado.
> +
> +Advertencias sobre el CFS con control de cuota de ancho de banda
> +----------------------------------------------------------------
> +
> +Una vez una "slice" se asigna a una cpu esta no expira. A pesar de eso t=
odas,
> +excepto las "slices" menos las de 1ms, puede ser devueltas a la reserva =
global
> +si todos los hilos en esa cpu pasan a ser no ejecutables. Esto se config=
ura
> +en el tiempo de compilaci=C3=B3n por la variable min_cfs_rq_runtime. Est=
o es un
> +ajuste en la eficacia que ayuda a prevenir a=C3=B1adir bloqueos en el ca=
ndado global.
> +
> +El hecho de que las "slices" de una cpu local no expiren tiene como resu=
ltado
> +algunos casos extremos interesantes que debieran ser comprendidos.
> +
> +Para una aplicaci=C3=B3n que es un cgroup y que est=C3=A1 limitada en su=
 uso de cpu
> +es un punto discutible ya que de forma natural consumir=C3=A1 toda su pa=
rte
> +de cuota as=C3=AD como tambi=C3=A9n la totalidad de su cuota en cpu loca=
les en cada
> +periodo. Como resultado se espera que nr_periods sea aproximadamente igu=
al
> +a nr_throttled, y que cpuacct.usage se incremente aproximadamente igual
> +a cfs_quota_us en cada periodo.
> +
> +Para aplicaciones que tienen un gran n=C3=BAmero de hilos de ejecuci=C3=
=B3n y que no
> +estan ligadas a una cpu, este matiz de la no-expiraci=C3=B3n permite que=
 las
> +aplicaciones brevemente sobrepasen su cuota l=C3=ADmite en la cantidad q=
ue
> +no ha sido usada en cada cpu en la que el grupo de tareas se est=C3=A1 e=
jecutando
> +(t=C3=ADpicamente como mucho 1ms por cada cpu o lo que se ha definido co=
mo
> +min_cfs_rq_runtime). Este peque=C3=B1o sobreuso =C3=BAnicamente tiene lu=
gar si
> +la cuota que ha sido asignada a una cpu y no ha sido completamente usada
> +o devuelta en periodos anteriores. Esta cantidad de sobreuso no ser=C3=
=A1
> +transferida entre n=C3=BAcleos. Como resultado, este mecanismo todav=C3=
=ADa cumplir=C3=A1
> +estrictamente los l=C3=ADmites de la tarea de grupo en el promedio del u=
so,
> +pero sobre una ventana de tiempo mayor que un =C3=BAnico periodo. Esto
> +tambi=C3=A9n limita la habilidad de un sobreuso a no m=C3=A1s de 1ms por=
 cada cpu.
> +Esto provee de una experiencia de uso m=C3=A1s predecible para aplicacio=
nes
> +con muchos hilos y con l=C3=ADmites de cuota peque=C3=B1os en m=C3=A1qui=
nas con muchos
> +n=C3=BAcleos. Esto tambi=C3=A9n elimina la propensi=C3=B3n a limitar est=
as
> +aplicaciones mientras que simult=C3=A1neamente usan menores cuotas
> +de uso por cpu. Otra forma de decir esto es que permitiendo que
> +la parte no usada de una "slice" permanezca v=C3=A1lida entre periodos
> +disminuye la posibilidad de malgastare cuota que va a expirar en
> +las reservas de la cpu locales que no necesitan una "slice" completa
> +de tiempo de ejecuci=C3=B3n de cpu.
> +
> +La interacci=C3=B3n entre las aplicaciones ligadas a una CPU y las que n=
o est=C3=A1n
> +ligadas a ninguna cpu ha de ser tambi=C3=A9n considerada, especialmente =
cuando
> +un =C3=BAnico n=C3=BAcleo tiene un uso del 100%. Si se da a cada una de =
esas
> +aplicaciones la mitad de la capacidad de una CPU-n=C3=BAcleo y ambas
> +est=C3=A1n gestionadas en la misma CPU es te=C3=B3ricamente posible que =
la aplicaci=C3=B3n
> +no ligada a ninguna CPU use su 1ms adicional de cuota en algunos periodo=
s,
> +y por tanto evite que la aplicaci=C3=B3n ligada a una CPU pueda usar su
> +cuota completa por esa misma cantidad. En esos caso el algoritmo CFS (ve=
a
> +sched-design-CFS.rst) el que decida qu=C3=A9 aplicaci=C3=B3n es la elegi=
da para
> +ejecutarse, ya que ambas ser=C3=A1n candidatas a ser ejecutadas y tienen
> +cuota restante. Esta discrepancia en el tiempo de ejecuci=C3=B3n se comp=
ensar=C3=A1
> +en los periodos siguientes cuando el sistema est=C3=A9 inactivo.
> +
> +Ejemplos
> +---------
> +
> +1. Un grupo limitado a 1 CPU de tiempo de ejecuci=C3=B3n.
> +
> +    Si el periodo son 250ms y la cuota son 250ms el grupo de tareas tend=
r=C3=A1 el tiempo
> +    de ejecuci=C3=B3n de 1 CPU cada 250ms::
> +
> +       # echo 250000 > cpu.cfs_quota_us /* cuota =3D 250ms */
> +       # echo 250000 > cpu.cfs_period_us /* periodo =3D 250ms */
> +
> +2. Un grupo limitado al tiempo de ejecuci=C3=B3n de 2 CPUs en una m=C3=
=A1quina varias CPUs.
> +
> +    Con un periodo de 500ms y una cuota de 1000ms el grupo de tareas tie=
ne el tiempo
> +    de ejecuci=C3=B3n de 2 CPUs cada 500ms::
> +
> +       # echo 1000000 > cpu.cfs_quota_us /* cuota =3D 1000ms */
> +       # echo 500000 > cpu.cfs_period_us /* periodo =3D 500ms */
> +
> +    El periodo m=C3=A1s largo aqu=C3=AD permite una capacidad de r=C3=A1=
faga mayor.
> +
> +3. Un grupo limitado a un 20% de 1 CPU.
> +
> +    Con un periodo de 50ms, 10ms de cuota son equivalentes al 20% de 1 C=
PUs::
> +
> +       # echo 10000 > cpu.cfs_quota_us /* cuota =3D 10ms */
> +       # echo 50000 > cpu.cfs_period_us /* periodo =3D 50ms */
> +
> +    Usando un periodo peque=C3=B1o aqu=C3=AD nos aseguramos una respuest=
a de
> +    la latencia consistente a expensas de capacidad de r=C3=A1faga.
> +
> +4. Un grupo limitado al 40% de 1 CPU, y permite acumular adicionalmente
> +   hasta un 20% de 1 CPU.
> +
> +    Con un periodo de 50ms, 20ms de cuota son equivalentes al 40% de
> +    1 CPU. Y 10ms de r=C3=A1faga, son equivalentes a un 20% de 1 CPU::
> +
> +       # echo 20000 > cpu.cfs_quota_us /* cuota =3D 20ms */
> +       # echo 50000 > cpu.cfs_period_us /* periodo =3D 50ms */
> +       # echo 10000 > cpu.cfs_burst_us /* r=C3=A1faga =3D 10ms */
> +
> +    Un ajuste mayor en la capacidad de almacenamiento (no mayor que la c=
uota)
> +    permite una mayor capacidad de r=C3=A1faga.
> +
> --
> 2.39.2
>

